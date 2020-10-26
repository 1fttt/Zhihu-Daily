//
//  HomepageViewController.m
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/10/16.
//  Copyright © 2020 房彤. All rights reserved.
//

#import "HomepageViewController.h"
#import "MyViewController.h"
#import "Manager.h"
#import "HomepageTableViewCell.h"
#import "HomeCellViewController.h"
#import "HomeTopStoriesViewController.h"


@interface HomepageViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>


@end

@implementation HomepageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
    
}

- (void)addView {
    self.view.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
    
    _homeView = [[HomepageView alloc] initWithFrame:self.view.frame];
    [_homeView initView];
    [self.view addSubview:_homeView];

    _homeView.tableView.delegate = self;
    _homeView.tableView.dataSource = self;
    
    [_homeView.tableView registerClass:[HomepageTableViewCell class] forCellReuseIdentifier:@"homecell1"];
    
    
    //导航栏
 
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = rightView.bounds;
    [rightButton setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(pressNext) forControlEvents:UIControlEventTouchUpInside];
    
    [rightView addSubview:rightButton];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];

    self.navigationItem.rightBarButtonItem = rightItem;
    
     Manager *manager = [Manager shareManager];
        [manager getModelSucceed:^(HomepageModel * _Nullable homepageModel) {
            NSLog(@"-----------");
            NSLog(@"%@", homepageModel);
            NSLog(@"-----------");
            _model = [[HomepageModel alloc] init];
            _model = homepageModel;
            //_imageArray = [[NSMutableArray alloc] initWithArray:_model.top_stories ];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.homeView.tableView reloadData];
            });
    //        [self.homeView.tableView reloadData];

        } error:^(NSError * _Nonnull error) {

        }];
    
}

- (void)pressNext {
    MyViewController *myView = [[MyViewController alloc] init];
    [self.navigationController pushViewController:myView animated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _model.stories.count + 1;
   // return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 400;
    } else {
        return 155;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        HomepageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

        if (cell == nil && _model.top_stories.count != 0) {

             cell = [[HomepageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            
            [self loadScroller];
            [cell.contentView addSubview:_scrollView];
            
            [self loadPageController];
            [cell.contentView addSubview:_pageController];
            
            [self loadTimer];

        
        }
        if (cell) {
            return cell;
        }
        
        
    } else {
    
        HomepageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homecell1" forIndexPath:indexPath];

        cell.titleLabel.text = [_model.stories[indexPath.row - 1] title];
        cell.hintLabel.text = [_model.stories[indexPath.row - 1] hint];

        Stories *storiesModel = _model.stories[indexPath.row - 1];
        NSString *urlString = [NSString stringWithFormat:@"%@", storiesModel.images[0]];

        NSData *data= [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
                       
        cell.imageview.image = [UIImage imageWithData:data];

        return cell;
    }
    return [[UITableViewCell alloc] init];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > 0) {
        [self pressCellView];
    }
}


- (void)loadScroller {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 414, 400)];
    _topURLArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < _model.top_stories.count; i++) {
        CGFloat imageViewX = i * 414;
        UIButton *imageViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        imageViewButton.frame = CGRectMake(imageViewX, 0, 414, 400);
        imageViewButton.tag = i;
        NSString *urlString = [NSString stringWithFormat:@"%@",[ _model.top_stories[i] image]];
        
        NSData *data= [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        
        NSString *urlStr = [NSString stringWithFormat:@"%@",[_model.top_stories[i] url]];
        [_topURLArray addObject:urlStr];
        
        [imageViewButton setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
        [imageViewButton addTarget:self action:@selector(pressTopView:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:imageViewButton];
        
    }
    _scrollView.contentSize = CGSizeMake(_model.top_stories.count * 414, 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    
}


- (void)loadPageController {
    _pageController = [[UIPageControl alloc] initWithFrame:CGRectMake(170, 380, 20, 10)];
    _pageController.numberOfPages = _model.top_stories.count;
    _pageController.currentPage = 0;
    _pageController.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageController.pageIndicatorTintColor = [UIColor grayColor];
}

//加载计时器
- (void)loadTimer{
    //设置定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(pageChanged:) userInfo:nil repeats:YES];
    NSRunLoop *mainLoop = [NSRunLoop mainRunLoop];
    [mainLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}


- (void)pageChanged:(id)sender {
    
    NSInteger currentPage = _pageController.currentPage;

    CGPoint offset = _scrollView.contentOffset;
    if (currentPage >= _model.top_stories.count - 1) {
        currentPage = 0;
        offset.x = 0;
    } else {
        currentPage++;
        offset.x += 414;
    }
    _pageController.currentPage = currentPage;
    [_scrollView setContentOffset:offset animated:NO];
    
}

//根据偏移量获取当前页码
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    CGPoint offset=scrollView.contentOffset;
    NSInteger currentPage=offset.x / 414;
    _pageController.currentPage=currentPage;
    
}

//设置代理方法,当开始拖拽的时候,让计时器停止
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //使定时器失效
    [self.timer invalidate];
}

//设置代理方法,当拖拽结束的时候,调用计时器,让其继续自动滚动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    [self loadTimer];
}

- (void)pressCellView {
    HomeCellViewController *view = [[HomeCellViewController alloc] init];
    
    [self presentViewController:view animated:YES completion:nil];
}

- (void)pressTopView:(UIButton *)button {
    HomeTopStoriesViewController *topView = [[HomeTopStoriesViewController alloc] init];
    
   // topView.urlArray = _topURLArray;
    topView.urlStr = [NSString stringWithFormat:@"%@", _topURLArray[button.tag]];
    [self.navigationController pushViewController:topView animated:YES];
    //[self presentViewController:topView animated:YES completion:nil];
    
}


- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.toolbarHidden = YES;
}

@end

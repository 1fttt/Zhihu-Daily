//
//  HomepageView.m
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/10/16.
//  Copyright © 2020 房彤. All rights reserved.
//

#import "HomepageView.h"
#import "MyViewController.h"
#import "Manager.h"
#import "HomepageTableViewCell.h"
#import "HomeCellViewController.h"
#import "HomeTopStoriesViewController.h"
#import "BeforeNewsModel.h"

int isLoading = 0;
int a = 1;
@implementation HomepageView 

- (void)initView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 85, self.frame.size.width, self.frame.size.height - 85) style:UITableViewStylePlain];
    [self addSubview:_tableView];
    _tableView.backgroundColor = [UIColor greenColor];
    _tableView.tag = 1;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerClass:[HomepageTableViewCell class] forCellReuseIdentifier:@"homecell1"];
    
    _beforeModel = [[BeforeNewsModel alloc] init];
    _imageViewButtonArray = [[NSMutableArray alloc] init];
    _beforeNewsArray = [[NSMutableArray alloc] init];
    
    
     Manager *manager = [Manager shareManager];
        [manager getModelSucceed:^(HomepageModel * _Nullable homepageModel) {
            NSLog(@"-----------");
            NSLog(@"%@", homepageModel);
            NSLog(@"-----------");
            _model = [[HomepageModel alloc] init];
            _model = homepageModel;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
    //        [self.homeView.tableView reloadData];

        } error:^(NSError * _Nonnull error) {

        }];


    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _model.stories.count + 1 ;
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
//        [self pressCellView];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"cellView" object:nil];
    }
}


- (void)loadScroller {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 414, 400)];
    
    _topURLArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < _model.top_stories.count; i++) {
        CGFloat imageViewX = i * 414;
        UIButton *imageViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_imageViewButtonArray addObject:imageViewButton];
        imageViewButton.frame = CGRectMake(imageViewX, 0, 414, 400);
        imageViewButton.tag = i;
        NSString *urlString = [NSString stringWithFormat:@"%@",[ _model.top_stories[i] image]];
        
        NSData *data= [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        
        NSString *urlStr = [NSString stringWithFormat:@"%@",[_model.top_stories[i] url]];
        [_topURLArray addObject:urlStr];
        
        [imageViewButton setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
        
        [_scrollView addSubview:imageViewButton];
        
    }
    _scrollView.contentSize = CGSizeMake(_model.top_stories.count * 414, 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"imageButton" object:nil];
    
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



//偏移量 上拉刷新 下拉加载
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (scrollView.tag == 1) {
        if (!isLoading) {

          float height = _tableView.frame.size.height < scrollView.contentSize.height ? _tableView.frame.size.height : scrollView.contentSize.height;
            
            if ((height - scrollView.contentSize.height + scrollView.contentOffset.y) / height > 0.2) {
                if (a) {
                    NSLog(@"上拉加载");
                    a = 0;
                Manager *manager = [Manager shareManager];
                [manager getBeforeNewsModel:^(BeforeNewsModel * _Nullable beforeNewsModel) {
                    //NSLog(@"%@", beforeNewsModel);
                    _beforeModel = beforeNewsModel;
                    
                    [_beforeNewsArray addObject:beforeNewsModel];
                    a = 1;
                } error:^(NSError * _Nonnull error) {

                }];
                   
                }

            } else if (-scrollView.contentOffset.y / height > 0.1) {
                NSLog(@"下拉刷新");
            }
            isLoading = 0;
        }
    }

}




@end

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
#import "HomeTopStoriesViewController.h"
#import "BeforeNewsModel.h"
#import <pthread.h>
int isLoading = 0;
int a = 1;
@implementation HomepageView 

- (void)initView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 414, 896) style:UITableViewStyleGrouped];
    //_tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStyleGrouped];
    [self addSubview:_tableView];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.tag = 1;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerClass:[HomepageTableViewCell class] forCellReuseIdentifier:@"homecell1"];
    
   // _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.001) ];
    
    _beforeModel = [[BeforeNewsModel alloc] init];
    _imageViewButtonArray = [[NSMutableArray alloc] init];
    _beforeNewsArray = [[NSMutableArray alloc] init];
    _beforeURLStr = [[NSString alloc] init];
    
    
    _cellURLArray = [[NSMutableArray alloc] init];
    _cellidArray = [[NSMutableArray alloc] init];
    _cellExtraArray = [[NSMutableArray alloc] init];
    _cellTitleArray = [[NSMutableArray alloc] init];
    _cellImageDataArray = [[NSMutableArray alloc] init];
    
    
    //_topStoriesURLArr = [[NSMutableArray alloc] init];
    
     Manager *manager = [Manager shareManager];
        [manager getModelSucceed:^(HomepageModel * _Nullable homepageModel) {
            NSLog(@"-----------");
            NSLog(@"%@", homepageModel);
            NSLog(@"-----------");
            self->_model = [[HomepageModel alloc] init];
            _model = homepageModel;
            NSString *beforedate = [NSString stringWithString:_model.date];
            _beforeURLStr = beforedate;
            
            for (Stories *stories in self->_model.stories) {
                [_cellidArray addObject:stories.ID];
                [_cellURLArray addObject:stories.url];
                [_cellTitleArray addObject:stories.title];
                
                NSString *urlString = [NSString stringWithFormat:@"%@", stories.images[0]];
                NSData *data= [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
                
                [_cellImageDataArray addObject:UIImagePNGRepresentation([UIImage imageWithData:data])];
                
                [manager getExtraModel:^(ExtraModel * _Nullable extraModel) {
                        [_cellExtraArray addObject:extraModel];
                } error:^(NSError * _Nonnull error) {
                        
                } ID:stories.ID];
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });

            
            
            
        } error:^(NSError * _Nonnull error) {

        }];


    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1 + _beforeNewsArray.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _model.stories.count + 1 ;
    } else {
        BeforeNewsModel *beforemodel = _beforeNewsArray[section - 1];
        return beforemodel.stories.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && indexPath.section == 0) {
        return 400;
    } else {
        return 115;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
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
    } else {
        BeforeNewsModel *model = _beforeNewsArray[indexPath.section - 1];
        HomepageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homecell1" forIndexPath:indexPath];

        cell.titleLabel.text = [model.stories[indexPath.row] title];
        cell.hintLabel.text = [model.stories[indexPath.row] hint];

        Stories *storiesModel = model.stories[indexPath.row];
        NSString *urlString = [NSString stringWithFormat:@"%@", storiesModel.images[0]];

        NSData *data= [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
                       
        cell.imageview.image = [UIImage imageWithData:data];


        
        return cell;
    }
    return [[UITableViewCell alloc] init];

}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section > 0) {
        
        NSString *dateStr = (NSString *)[_beforeNewsArray[section -  1] date];
        
        NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
        [inputFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
        [inputFormatter setDateFormat:@"yyyyMMdd"];
        NSDate *inputDate = [inputFormatter dateFromString:dateStr];
    
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

        [formatter setLocale:[NSLocale currentLocale]];
        [formatter setDateFormat:@"MM 月 dd 日"];
        NSString *str = [formatter stringFromDate:inputDate];
        NSLog(@"%@", str);

        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 414, 20)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 20)];
        label.font = [UIFont boldSystemFontOfSize:16];
        label.textColor = [UIColor colorWithWhite:0.6 alpha:1];
        label.text = str;
        
        
        [headView addSubview:label];
        return headView;
    }
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.001;
    } else {
        return 23;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return  0.001;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section > 0 || (indexPath.section == 0 && indexPath.row > 0)) {
        //[self pressCellView];
        
        if (indexPath.section == 0) {
            _currentcell = indexPath.row - 1;
        } else {
            _currentcell = _model.stories.count;
            for (int i = 1; i < indexPath.section; i++) {
                BeforeNewsModel *model = _beforeNewsArray[i - 1];
                _currentcell += model.stories.count;
            }
            _currentcell += indexPath.row;
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"cellView" object:nil];
    }
}


- (void)loadScroller {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 414, 400)];
    
    _topURLArray = [[NSMutableArray alloc] init];
    _idArray = [[NSMutableArray alloc] init];
    _topExtraArray = [[NSMutableArray alloc] init];
    //_imageArray = [[NSMutableArray alloc] init];
    _titleArray = [[NSMutableArray alloc] init];
    _imageDataArray = [[NSMutableArray alloc] init];
    
    Manager *manager = [Manager shareManager];
    
    for (int i = 0; i < _model.top_stories.count; i++) {
        
        CGFloat imageViewX = i * 414;
        
        UIButton *imageViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_imageViewButtonArray addObject:imageViewButton];
        
        imageViewButton.frame = CGRectMake(imageViewX, 0, 414, 400);
        imageViewButton.tag = i;
        NSString *urlString = [NSString stringWithFormat:@"%@",[ _model.top_stories[i] image]];
        
        NSData *data= [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        
        
        [manager getExtraModel:^(ExtraModel * _Nullable extraModel) {
            [self->_topExtraArray addObject:extraModel];
        } error:^(NSError * _Nonnull error) {
            
        } ID:[_model.top_stories[i] ID]];
        
        [imageViewButton setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
        
        NSString *urlStr = [NSString stringWithFormat:@"%@",[_model.top_stories[i] url]];
        [_topURLArray addObject:urlStr];
        
        NSString *idStr = [NSString stringWithFormat:@"%@", [_model.top_stories[i] ID]];
        [_idArray addObject:idStr];
        
        NSString *titleStr = [NSString stringWithFormat:@"%@", [_model.top_stories[i] title]];
        [_titleArray addObject:titleStr];
        
        NSData *imageData = UIImagePNGRepresentation([UIImage imageWithData:data]);
        [_imageDataArray addObject:imageData];
        
        [_scrollView addSubview:imageViewButton];
        
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(20, 295, 350, 60);
        label.font = [UIFont boldSystemFontOfSize:24];
        label.textColor = [UIColor whiteColor];
        label.numberOfLines = 2;
        label.text = [NSString stringWithString:[_model.top_stories[i] title]];
        [imageViewButton addSubview:label];
        
        UILabel *hintLabel = [[UILabel alloc] init];
        hintLabel.frame = CGRectMake(20, 350, 350, 30);
        hintLabel.font = [UIFont systemFontOfSize:15];
        hintLabel.textColor = [UIColor colorWithWhite:0.8 alpha:1];
        hintLabel.text = [NSString stringWithString:[_model.top_stories[i] hint]];
        [imageViewButton addSubview:hintLabel];
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
            
            if ((height - scrollView.contentSize.height + scrollView.contentOffset.y) / height > 0.1) {
                if (a) {
                    NSLog(@"上拉加载");
                    a = 0;
                    
                    //footView
                    
                    UIActivityIndicatorView *act = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
                    act.color = [UIColor blackColor];
                    [act startAnimating];
                    _tableView.tableFooterView = act;
                    [_tableView reloadData];

                    
                    Manager *manager = [Manager shareManager];
                    [manager getBeforeNewsModel:^(BeforeNewsModel * _Nullable beforeNewsModel) {
                        _beforeModel = beforeNewsModel;
                        
                        [_beforeNewsArray addObject:beforeNewsModel];
                        a = 1;
                        
                        NSString *beforeDate = beforeNewsModel.date;
                        _beforeURLStr = beforeDate;
                        
                        
                        for (StoriesModel *storiesmodel in _beforeModel.stories) {
                            [_cellidArray addObject:storiesmodel.ID];
                            [_cellURLArray addObject:storiesmodel.url];
                            
                            [_cellTitleArray addObject:storiesmodel.title];
                            
                            NSString *urlString = [NSString stringWithFormat:@"%@", storiesmodel.images[0]];
                            NSData *data= [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
                            
                            [_cellImageDataArray addObject:UIImagePNGRepresentation([UIImage imageWithData:data])];
                            
                            
                            [manager getExtraModel:^(ExtraModel * _Nullable extraModel) {
                                [_cellExtraArray addObject:extraModel];
                            } error:^(NSError * _Nonnull error) {
                                
                            } ID:storiesmodel.ID];
                            
                        }
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                           
                            
                            [act stopAnimating];
                            self->_tableView.tableFooterView = nil;
                            
                            [_tableView reloadData];
                            
                            
                        });
                    } error:^(NSError * _Nonnull error) {
                    
                    } urlStr:_beforeURLStr];
            
                }

            } else if (-scrollView.contentOffset.y / height > 0.1) {
                NSLog(@"下拉刷新");
            }
            isLoading = 0;
        }
    }

}



@end

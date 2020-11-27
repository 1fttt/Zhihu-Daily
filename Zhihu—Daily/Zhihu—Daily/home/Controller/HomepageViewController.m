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
#import "HomeTopStoriesViewController.h"
#import "FMDBManager.h"

@interface HomepageViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>


@end

@implementation HomepageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
    
    FMDBManager *manager = [FMDBManager shareManager];
    [manager creatTable];

}

- (void)addView {
    self.view.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
    
    _homeView = [[HomepageView alloc] initWithFrame:self.view.frame];
    [_homeView initView];
    [self.view addSubview:_homeView];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buttonSetTarget) name:@"imageButton" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pressCellView) name:@"cellView" object:nil];
    
    //导航栏
 
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = rightView.bounds;
    [rightButton setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(pressNext) forControlEvents:UIControlEventTouchUpInside];
    
    [rightView addSubview:rightButton];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];

    self.navigationItem.rightBarButtonItem = rightItem;
   
    
    UIView *dateView = [[UIView alloc] initWithFrame:CGRectMake(5, 15, 40, 40)];
    
    UILabel *dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 25)];
    UILabel *monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, 40, 15)];
    
    [dateView addSubview:monthLabel];
    [dateView addSubview:dayLabel];
    
    NSDate *date = [NSDate date];
    
    NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
    [dayFormatter setDateFormat:@"dd"];
   
    NSDateFormatter *monthFormatter = [[NSDateFormatter alloc] init];
    [monthFormatter setDateFormat:@"MMM"];
    
    NSString *dayStr = [dayFormatter stringFromDate:date];
    NSString *monthStr = [monthFormatter stringFromDate:date];
    
    dayLabel.textColor = [UIColor colorWithWhite:0.15 alpha:1];
    dayLabel.text = dayStr;
    dayLabel.font = [UIFont boldSystemFontOfSize:20];
    dayLabel.textAlignment = NSTextAlignmentCenter;
    
    monthLabel.textColor = [UIColor colorWithWhite:0.2 alpha:1];
    monthLabel.text = monthStr;
    monthLabel.font = [UIFont boldSystemFontOfSize:14];
    monthLabel.textAlignment = NSTextAlignmentCenter;
    

    UILabel *zhihuLabel = [[UILabel alloc] init];
    zhihuLabel.frame = CGRectMake(50, 0, 100, 40);
    zhihuLabel.text = @"知乎日报";
    zhihuLabel.font = [UIFont boldSystemFontOfSize:26];
    
    
    UIBarButtonItem *dateItem = [[UIBarButtonItem alloc] initWithCustomView:dateView];
    UIBarButtonItem *zhihuItem = [[UIBarButtonItem alloc] initWithCustomView:zhihuLabel];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:dateItem, zhihuItem, nil];
    
    
    
}


- (void)buttonSetTarget {
    
    for (UIButton *button in _homeView.imageViewButtonArray) {
        [button addTarget:self action:@selector(pressTopView:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)pressNext {
    MyViewController *myView = [[MyViewController alloc] init];
    [self.navigationController pushViewController:myView animated:YES];
}


//点击轮播图
- (void)pressTopView:(UIButton *)button {
    HomeTopStoriesViewController *topView = [[HomeTopStoriesViewController alloc] init];
    topView.urlArray = [[NSArray alloc] init];
    topView.urlArray = _homeView.topURLArray;
    
    topView.idArray = [[NSMutableArray alloc] init];
    topView.idArray = _homeView.idArray;
    
    
    topView.currentpage = button.tag;

    //topView.extraArray = [[NSMutableArray alloc] init];
    topView.extraArray = _homeView.topExtraArray;
       
    topView.titleArray = [[NSMutableArray alloc] init];
    topView.titleArray = _homeView.titleArray;
    
    topView.imageDataArray = [[NSMutableArray alloc] init];
    topView.imageDataArray = _homeView.imageDataArray;
    
    [self.navigationController pushViewController:topView animated:YES];
    
}

//点击cell
- (void)pressCellView {
    
    HomeTopStoriesViewController *cellView = [[HomeTopStoriesViewController alloc] init];
    
    cellView.urlArray = [[NSArray alloc] init];
    cellView.urlArray = _homeView.cellURLArray;
    
    
    cellView.idArray = [[NSMutableArray alloc] init];
    cellView.idArray = _homeView.cellidArray;
    
    cellView.currentpage = _homeView.currentcell;
    
    
    cellView.extraArray = [[NSMutableArray alloc] init];
    cellView.extraArray = _homeView.cellExtraArray;

    cellView.titleArray = _homeView.cellTitleArray;
    cellView.imageDataArray = _homeView.cellImageDataArray;
    
    [self.navigationController pushViewController:cellView animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.toolbarHidden = YES;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

@end

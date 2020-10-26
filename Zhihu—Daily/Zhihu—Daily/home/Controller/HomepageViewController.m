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


- (void)pressTopView:(UIButton *)button {
    HomeTopStoriesViewController *topView = [[HomeTopStoriesViewController alloc] init];
    
    topView.urlStr = [NSString stringWithFormat:@"%@", _homeView.topURLArray[button.tag] ];
    [self.navigationController pushViewController:topView animated:YES];
    
}

- (void)pressCellView {
    HomeCellViewController *view = [[HomeCellViewController alloc] init];
    
    [self presentViewController:view animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.toolbarHidden = YES;
}

@end

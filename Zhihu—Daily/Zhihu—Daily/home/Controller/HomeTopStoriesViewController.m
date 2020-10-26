//
//  HomeTopStoriesViewController.m
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/10/19.
//  Copyright © 2020 房彤. All rights reserved.
//

#import "HomeTopStoriesViewController.h"

@interface HomeTopStoriesViewController ()

@end

@implementation HomeTopStoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //工具栏
    self.navigationController.toolbarHidden = NO;
    self.navigationController.toolbar.translucent = NO;

    
    _topStoriesView = [[HomeTopStoriesView alloc] initWithFrame:CGRectMake(0, 40, 414, 790)];
   // _topStoriesView = [[HomeTopStoriesView alloc] initWithFrame:CGRectMake(0, 20, 414, 833)];
    [self.view addSubview:_topStoriesView];
    _topStoriesView.storyURLStr = [NSString stringWithFormat:@"%@", _urlStr];
    [_topStoriesView initView];
    
    
    //导航栏隐藏
    //[self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:_webView];
//    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]]];
    
    
    //返回
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui-copy-copy"] style:UIBarButtonItemStylePlain target:self action:@selector(pressBack)];
    
    
    //评论
    [_topStoriesView initToolbarItem];
    [_topStoriesView.itemButton setImage:[UIImage imageNamed:@"pinglun"] forState:UIControlStateNormal];
    [_topStoriesView.itemButton addTarget:self action:@selector(pressBack) forControlEvents:UIControlEventTouchUpInside];
    _topStoriesView.itemLabel.text = @"26";
    
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithCustomView:_topStoriesView.itemView];

    
    //点赞
    [_topStoriesView initToolbarItem];
    _topStoriesView.itemLabel.text = @"493";
    [_topStoriesView.itemButton setImage:[UIImage imageNamed:@"zanpress"] forState:UIControlStateNormal];
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithCustomView:_topStoriesView.itemView];
    self.navigationController.toolbar.tintColor = [UIColor blackColor];
   
    //收藏
    UIBarButtonItem *item4 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shoucang"] style:UIBarButtonItemStylePlain target:self action:@selector(pressBack)];
    
    //分享
    UIBarButtonItem *item5 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shangchuan-2"] style:UIBarButtonItemStylePlain target:self action:@selector(pressBack)];
    
    //创建自动计算宽度按钮
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
    
    NSArray *arrayBtns = [NSArray arrayWithObjects:item1, btn, item2, btn, item3, btn, item4, btn, item5, nil];
    self.toolbarItems = arrayBtns;
    
    

}

- (void)pressBack {
    [self.navigationController popViewControllerAnimated:YES];
}

@end

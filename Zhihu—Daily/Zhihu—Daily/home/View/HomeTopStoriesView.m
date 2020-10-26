//
//  HomeTopStoriesView.m
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/10/20.
//  Copyright © 2020 房彤. All rights reserved.
//

#import "HomeTopStoriesView.h"



@implementation HomeTopStoriesView



- (void)initView {
    self.backgroundColor = [UIColor whiteColor];
    _wkWebView = [[WKWebView alloc] initWithFrame:self.bounds];
    [self addSubview:_wkWebView];
    [_wkWebView loadRequest:[NSURLRequest requestWithURL:[ NSURL URLWithString:_storyURLStr]]];
    
//    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:@selector(pressBack)];
    
//    _plView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
//
//    _pinglunButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _pinglunButton.frame = CGRectMake(0, 0, 20, 35);
//    [_pinglunButton setImage:[UIImage imageNamed:@"pinglun.png"] forState:UIControlStateNormal];
//    [_plView addSubview:_pinglunButton];
//
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(19, 0, 25, 35)];
//    [_plView addSubview:label];
//    label.text = @"11";
    
    
}


- (void)initToolbarItem {
    _itemView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 49, 40)];
    _itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _itemButton.frame = CGRectMake(0, 5, 24, 30);
    //[_pinglunButton setImage:[UIImage imageNamed:@"pinglun.png"] forState:UIControlStateNormal];
    [_itemView addSubview:_itemButton];
    
    _itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(24, 0, 25, 30)];
    _itemLabel.font = [UIFont systemFontOfSize:10];
    [_itemView addSubview:_itemLabel];
    
    //_label.text = @"11";
    
}

@end

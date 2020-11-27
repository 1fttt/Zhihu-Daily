//
//  HomeTopStoriesView.m
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/10/20.
//  Copyright © 2020 房彤. All rights reserved.
//

#import "HomeTopStoriesView.h"
#import "ExtraModel.h"


@implementation HomeTopStoriesView

- (void)initView {
    self.backgroundColor = [UIColor whiteColor];
    
    
    
//    _wkWebView = [[WKWebView alloc] initWithFrame:self.bounds];
//    [self addSubview:_wkWebView];
//    [_wkWebView loadRequest:[NSURLRequest requestWithURL:[ NSURL URLWithString:_storyURLStr]]];
    

    
    _webScrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    _webScrollView.tag = 1;

    int i = 0;
    for (NSString *str in _storyURLArray) {
        CGFloat webViewY = i * self.frame.size.height;
        WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, webViewY, self.frame.size.width, self.frame.size.height)];
        webView.tag = i;
        

        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        
        [_webScrollView addSubview:webView];
        i++;
    }
    
    _webScrollView.showsVerticalScrollIndicator = NO;
    _webScrollView.contentSize = CGSizeMake(414, i * self.frame.size.height);
    _webScrollView.pagingEnabled = YES;
    
    [self addSubview:_webScrollView];
    
    [self.webScrollView addObserver:self forKeyPath:@"contentOffest" options:NSKeyValueObservingOptionNew context:nil];
    
}


- (void)initToolbarItem {
    
    //设置工具栏评论点赞样式
    
    _commentItemView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 49, 40)];
    _popularityItemView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 49, 40)];
    
    _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _commentButton.frame = CGRectMake(0, 5, 24, 30);
    [_commentItemView addSubview:_commentButton];
    
    _popularityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _popularityButton.frame = CGRectMake(0, 5, 24, 30);
    [_popularityItemView addSubview:_popularityButton];
    
    _commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(24, 0, 25, 30)];
    _commentLabel.font = [UIFont systemFontOfSize:10];
    [_commentItemView addSubview:_commentLabel];
    
    _popularityLabel = [[UILabel alloc] initWithFrame:CGRectMake(24, 0, 25, 30)];
    _popularityLabel.font = [UIFont systemFontOfSize:10];
    [_popularityItemView addSubview:_popularityLabel];
    

    
}




@end

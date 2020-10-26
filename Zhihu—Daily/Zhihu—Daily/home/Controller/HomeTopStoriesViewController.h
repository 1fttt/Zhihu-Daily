//
//  HomeTopStoriesViewController.h
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/10/19.
//  Copyright © 2020 房彤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeTopStoriesView.h"
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeTopStoriesViewController : UIViewController

@property HomeTopStoriesView *topStoriesView;

@property (strong, nonatomic) WKWebView *webView;
@property void (^urlBlock) (NSString *str);
@property (nonatomic, copy) NSString *urlStr;
@property (nonatomic, copy) NSArray *urlArray;
@end

NS_ASSUME_NONNULL_END

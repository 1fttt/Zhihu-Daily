//
//  HomeTopStoriesView.h
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/10/20.
//  Copyright © 2020 房彤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>



NS_ASSUME_NONNULL_BEGIN

@interface HomeTopStoriesView : UIView

@property (nonatomic, copy) NSString *storyURLStr;
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) UIView *itemView;
@property (nonatomic, strong) UIButton *itemButton;
@property (nonatomic, strong) UILabel *itemLabel;

- (void)initView;
- (void)initToolbarItem;

@end

NS_ASSUME_NONNULL_END

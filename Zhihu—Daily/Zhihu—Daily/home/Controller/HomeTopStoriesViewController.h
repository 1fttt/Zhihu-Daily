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

@property (nonatomic, copy) NSArray *urlArray;
@property (nonatomic, copy) NSMutableArray *idArray;

@property (nonatomic, strong) NSMutableArray *extraArray;

@property (nonatomic, copy) NSString *longCommentNumStr;
@property (nonatomic, copy) NSString *shortCommentNumStr;
@property (nonatomic, copy) NSString *commentNumStr;
@property (nonatomic, assign) int currentpage;

@property (nonatomic, assign) NSInteger select;


@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *imageDataArray;

@property (nonatomic, strong) UIBarButtonItem *item4;

@end

NS_ASSUME_NONNULL_END

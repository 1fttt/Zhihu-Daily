//
//  HomepageViewController.h
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/10/16.
//  Copyright © 2020 房彤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomepageView.h"
#import "HomepageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomepageViewController : UIViewController

@property (nonatomic, strong) HomepageView *homeView;
@property (nonatomic, strong) HomepageModel *model;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageController;

@property (nonatomic, copy) NSMutableArray *topURLArray;

@end

NS_ASSUME_NONNULL_END

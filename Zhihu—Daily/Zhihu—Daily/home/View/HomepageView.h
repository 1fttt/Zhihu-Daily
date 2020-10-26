//
//  HomepageView.h
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/10/16.
//  Copyright © 2020 房彤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomepageModel.h"

#import "Masonry.h"

@class BeforeNewsModel;
NS_ASSUME_NONNULL_BEGIN

@interface HomepageView : UIView <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HomepageModel *model;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageController;



@property (nonatomic, copy) NSMutableArray *topURLArray;

@property (nonatomic, strong) NSMutableArray *imageViewButtonArray;
//@property (nonatomic, strong) UIButton *imageViewButton;

@property (nonatomic, strong) BeforeNewsModel *beforeModel;
@property (nonatomic, strong) NSMutableArray *beforeNewsArray;


- (void)initView;

@end

NS_ASSUME_NONNULL_END

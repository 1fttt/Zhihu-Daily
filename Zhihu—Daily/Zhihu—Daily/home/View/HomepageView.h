//
//  HomepageView.h
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/10/16.
//  Copyright © 2020 房彤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomepageModel.h"
#import "ExtraModel.h"
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


//@property (nonatomic, copy) NSMutableArray *topStoriesURLArr;

//轮播图图片按钮
@property (nonatomic, strong) NSMutableArray *imageViewButtonArray;


@property (nonatomic, strong) BeforeNewsModel *beforeModel;
@property (nonatomic, strong) NSMutableArray *beforeNewsArray;

@property (nonatomic, copy) NSString *beforeURLStr;

@property (nonatomic, assign) long currentcell;

//轮播图文章url、id、extra
@property (nonatomic, strong) NSMutableArray *topURLArray;
@property (nonatomic, strong) NSMutableArray *idArray;
@property (nonatomic, strong) NSMutableArray *topExtraArray;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *imageDataArray;

//cell文章、id、extra
@property (nonatomic, strong) NSMutableArray *cellURLArray;
@property (nonatomic, strong) NSMutableArray *cellidArray;
@property (nonatomic, strong) NSMutableArray *cellExtraArray;
@property (nonatomic, strong) NSMutableArray *cellTitleArray;
@property (nonatomic, strong) NSMutableArray *cellImageDataArray;




- (void)initView;

@end

NS_ASSUME_NONNULL_END

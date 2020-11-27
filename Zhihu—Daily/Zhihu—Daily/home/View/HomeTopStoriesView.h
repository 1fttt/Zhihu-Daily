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

@interface HomeTopStoriesView : UIView <UIScrollViewDelegate>



//@property (nonatomic, copy) NSString *storyURLStr;
@property (nonatomic, copy) NSArray *storyURLArray;

@property (nonatomic, strong) UIScrollView *webScrollView;

@property (nonatomic, strong) UIView *commentItemView;
@property (nonatomic, strong) UIView *popularityItemView;
@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic ,strong) UIButton *popularityButton;
@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic, strong) UILabel *popularityLabel;

@property (nonatomic, strong) UIView *itemView;
//@property (nonatomic, strong) UIButton *itemButton;
//@property (nonatomic, strong) UILabel *itemLabel;

@property (nonatomic, copy) NSArray *extraArray;




- (void)initView;
- (void)initToolbarItem;

@end

NS_ASSUME_NONNULL_END

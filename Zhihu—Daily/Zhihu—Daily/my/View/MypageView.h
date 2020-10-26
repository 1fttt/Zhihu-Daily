//
//  MypageView.h
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/10/18.
//  Copyright © 2020 房彤. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MypageView : UIView

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *modeButton;
@property (nonatomic, strong) UIButton *setButton;

- (void)initView;

@end

NS_ASSUME_NONNULL_END

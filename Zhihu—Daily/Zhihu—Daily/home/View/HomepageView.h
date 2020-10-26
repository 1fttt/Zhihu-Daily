//
//  HomepageView.h
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/10/16.
//  Copyright © 2020 房彤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomepageView : UIView

@property (nonatomic, strong) UITableView *tableView;

- (void)initView;

@end

NS_ASSUME_NONNULL_END

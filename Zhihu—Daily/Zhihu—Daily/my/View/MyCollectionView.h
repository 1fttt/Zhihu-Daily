//
//  MyCollectionView.h
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/11/20.
//  Copyright © 2020 房彤. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyCollectionView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *imageArray;

- (void)initView;

@end

NS_ASSUME_NONNULL_END

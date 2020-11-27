//
//  CommentView.h
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/11/5.
//  Copyright © 2020 房彤. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LongCommentModel;
@class ShortCommentModel;
@class CommentHeightModel;

NS_ASSUME_NONNULL_BEGIN

@interface CommentView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSString *idstr;
@property (nonatomic, copy) NSString *longCommentNumStr;
@property (nonatomic, copy) NSString *shortCommentNumStr;

@property LongCommentModel *longCommentModel;
@property ShortCommentModel *shortCommentModel;



@property NSMutableArray<CommentHeightModel*>* shortCommentHeightArray;
@property NSMutableArray<CommentHeightModel*>* longCommentHeightArray;


- (void)initView;

@end

NS_ASSUME_NONNULL_END

//
//  CommentTableViewCell.h
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/11/5.
//  Copyright © 2020 房彤. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentTableViewCell : UITableViewCell

@property UILabel *label;


@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *likeLabel;

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UIButton *spreadButton;
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, strong) UIButton *moreButton;


@end

NS_ASSUME_NONNULL_END

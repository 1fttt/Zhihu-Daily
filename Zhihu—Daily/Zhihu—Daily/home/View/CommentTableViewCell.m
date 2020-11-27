//
//  CommentTableViewCell.m
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/11/5.
//  Copyright © 2020 房彤. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "Masonry.h"
@implementation CommentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ([self.reuseIdentifier isEqualToString:@"longOrShort"]) {
        _label = [[UILabel alloc] init];
        [self.contentView addSubview:_label];
        _label.font = [UIFont boldSystemFontOfSize:15];
        
        _label.lineBreakMode = NSLineBreakByWordWrapping;
    }  else if ([self.reuseIdentifier isEqualToString:@"short"] || [self.reuseIdentifier isEqualToString:@"long"]) {
        
    
        //名字
        _authorLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_authorLabel];
        _authorLabel.font = [UIFont boldSystemFontOfSize:16];
        
        //时间
        _timeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_timeLabel];
        _timeLabel.textColor = [UIColor colorWithWhite:0.6 alpha:1];
        _timeLabel.font = [UIFont systemFontOfSize:15];
        
        //内容
        _contentLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_contentLabel];
        _contentLabel.font = [UIFont systemFontOfSize:16];
            
        //头像
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.layer.cornerRadius = 35 / 2;
        _avatarImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_avatarImageView];
        
//        //展开全文
//        _spreadButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self.contentView addSubview:_spreadButton];
//
        //赞
        _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_likeButton];
        
        //评论
        _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_commentButton];
        
        //更多
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_moreButton];
        
        //点赞数
        _likeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_likeLabel];
        _likeLabel.textColor = [UIColor colorWithWhite:0.6 alpha:1];
        _likeLabel.font = [UIFont systemFontOfSize:16];
        _likeLabel.textAlignment = NSTextAlignmentRight;
        
    } else if([self.reuseIdentifier isEqualToString:@"shortClose"] || [self.reuseIdentifier isEqualToString:@"longClose"]) {
        //名字
        _authorLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_authorLabel];
        _authorLabel.font = [UIFont boldSystemFontOfSize:16];
        
        //时间
        _timeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_timeLabel];
        _timeLabel.textColor = [UIColor colorWithWhite:0.6 alpha:1];
        _timeLabel.font = [UIFont systemFontOfSize:15];
        
        //内容
        _contentLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_contentLabel];
        _contentLabel.font = [UIFont systemFontOfSize:16];
            
        //头像
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.layer.cornerRadius = 35 / 2;
        _avatarImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_avatarImageView];
        
        //展开全文
        _spreadButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.contentView addSubview:_spreadButton];
        
        
        //赞
        _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_likeButton];
        
        //评论
        _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_commentButton];
        
        //更多
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_moreButton];
        
        //点赞数
        _likeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_likeLabel];
        _likeLabel.textColor = [UIColor colorWithWhite:0.6 alpha:1];
        _likeLabel.font = [UIFont systemFontOfSize:16];
        _likeLabel.textAlignment = NSTextAlignmentRight;
    }
//        else if ([self.reuseIdentifier isEqualToString:@"long"]) {
//        _authorLabel = [[UILabel alloc] init];
//        [self.contentView addSubview:_authorLabel];
//
//        _avatarImageView = [[UIImageView alloc] init];
//        [self.contentView addSubview:_avatarImageView];
//
//        _contentLabel = [[UILabel alloc] init];
//        [self.contentView addSubview:_contentLabel];
//
//        _timeLabel = [[UILabel alloc] init];
//        [self.contentView addSubview:_timeLabel];
//
//        _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self.contentView addSubview:_likeButton];
//
//        _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self.commentButton addSubview:_commentButton];
//
//        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self.commentButton addSubview:_moreButton];
//    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //_label.numberOfLines = 0;
    _label.frame = CGRectMake(15, 8, 100, 30);
    
    
    //头像
    [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(14);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(35);
    }];
    
    
    //名字
    [_authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(14);
        make.left.equalTo(_avatarImageView.mas_right).offset(10);
        make.width.equalTo(@200);
        make.height.mas_equalTo(30);
    }];
    
    
    //内容
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.authorLabel.mas_bottom).offset(6);
        make.left.equalTo(self.authorLabel.mas_left);
        make.width.mas_equalTo(330);
    
    }];
    
    //时间
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(14);
        make.left.equalTo(self.authorLabel.mas_left);
        make.width.equalTo(@90);
        make.height.mas_equalTo(20);
    }];
    
    
    //点赞
    [_likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.mas_top);
        make.left.equalTo(self.contentView.mas_right).offset(-90);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    //评论
    [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.mas_top);
        make.left.equalTo(self.likeButton.mas_right).offset(30);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    //更多
    [_moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.authorLabel.mas_top);
        make.right.equalTo(self.commentButton.mas_right);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    [_likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.likeButton.mas_top).offset(2);
        make.right.equalTo(self.likeButton.mas_left).offset(-4);
        make.width.mas_equalTo(21);
        make.height.equalTo(self.likeButton.mas_height);
    }];
    
    [_spreadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.mas_top);
        make.left.equalTo(self.timeLabel.mas_right).offset(10);
        make.width.mas_equalTo(60);
        make.height.equalTo(self.timeLabel.mas_height);
    }];
    
   
}

@end

//
//  CommentView.m
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/11/5.
//  Copyright © 2020 房彤. All rights reserved.
//

#import "CommentView.h"
#import "LongCommentModel.h"
#import "ShortCommentModel.h"
#import "Manager.h"
#import "CommentTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "CommentHeightModel.h"

@implementation CommentView 


- (void)initView {
    
    _longCommentModel = [[LongCommentModel alloc] init];
    _shortCommentModel = [[ShortCommentModel alloc] init];
    
    //计算高度
    _shortCommentHeightArray = [[NSMutableArray alloc] init];
    _longCommentHeightArray = [[NSMutableArray alloc] init];
    
//    _shortCloseCommentHeightArray = [[NSMutableArray alloc] init];
//    _longCloseCommentHeightArray = [[NSMutableArray alloc] init];
//
//    _shortStatusArray = [[NSMutableArray alloc] init];
//
    NSLog(@"%@", _idstr);
    
    Manager *manager = [Manager shareManager];
    [manager getLongCommentModel:^(LongCommentModel * _Nullable longCommentModel) {
        
        _longCommentModel = longCommentModel;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self->_tableView reloadData];
            
            CGSize strSize = CGSizeMake(370, MAXFLOAT);
            for (int i = 0; i < _longCommentModel.comments.count; i++) {
                NSString *longCommentStr = [_longCommentModel.comments[i] content];
                CGRect longCommentSize = [longCommentStr boundingRectWithSize:strSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:18]} context:nil];
                
                CommentHeightModel *commentHeightModel = [[CommentHeightModel alloc] init];
                commentHeightModel.openCommentHeight = longCommentSize.size.height;
                commentHeightModel.status = 0;
                commentHeightModel.height = commentHeightModel.openCommentHeight;
        
                
                UILabel *label = [[UILabel alloc] init];
                label.text = longCommentStr;
                label.font = [UIFont systemFontOfSize:16];
                label.frame = CGRectMake(0, 0, 330, longCommentSize.size.height);
                commentHeightModel.lines = longCommentSize.size.height / label.font.lineHeight;
                
                if (commentHeightModel.lines > 2) {
                    commentHeightModel.closeCommentHeight = label.font.lineHeight * 2;
                    commentHeightModel.height = commentHeightModel.closeCommentHeight;
                }
                
                [_longCommentHeightArray addObject:commentHeightModel];
                
            }
            
            
        });
        
    } error:^(NSError * _Nonnull error) {
        
    } ID:_idstr];
    
    [manager getShortCommentModel:^(ShortCommentModel * _Nullable shortCommentModel) {
        
        self->_shortCommentModel = shortCommentModel;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self->_tableView reloadData];
            
            CGSize strSize = CGSizeMake(370, MAXFLOAT);
            
            for (int i = 0; i < self->_shortCommentModel.comments.count; i++) {
                //NSString *shortCommentStr = [_shortCommentModel.comments[i] content];
                
                NSMutableString *str = [NSMutableString stringWithFormat:@"%@",  [self->_shortCommentModel.comments[i] content]];
                
                if ([self->_shortCommentModel.comments[i] reply_to]) {
                    [str appendFormat:@"\n// %@: %@", [[self->_shortCommentModel.comments[i] reply_to] author], [[self->_shortCommentModel.comments[i] reply_to] content]];
                }
                
                CGRect shortCommentSize = [str boundingRectWithSize:strSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:18]} context:nil];
                CommentHeightModel *commentHeightModel = [[CommentHeightModel alloc] init];
                commentHeightModel.openCommentHeight = shortCommentSize.size.height;
                commentHeightModel.status = 0;
                commentHeightModel.height = commentHeightModel.openCommentHeight;
                
                
                UILabel *label = [[UILabel alloc] init];
                label.text = str;
                label.font = [UIFont systemFontOfSize:16];
                label.frame = CGRectMake(0, 0, 330, shortCommentSize.size.height);
                commentHeightModel.lines = shortCommentSize.size.height / label.font.lineHeight;
                
                if (commentHeightModel.lines > 2) {
                    commentHeightModel.closeCommentHeight = label.font.lineHeight * 2;
                    commentHeightModel.height = commentHeightModel.closeCommentHeight;
                }
                
                [_shortCommentHeightArray addObject:commentHeightModel];
                
                NSLog(@"%d", commentHeightModel.lines);
            }
            
            
        });
        
        
    } error:^(NSError * _Nonnull error) {
        
    } ID:_idstr];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
    [self addSubview:_tableView];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerClass:[CommentTableViewCell class] forCellReuseIdentifier:@"longOrShort"];
    [_tableView registerClass:[CommentTableViewCell class] forCellReuseIdentifier:@"short"];
    [_tableView registerClass:[CommentTableViewCell class] forCellReuseIdentifier:@"long"];
    [_tableView registerClass:[CommentTableViewCell class] forCellReuseIdentifier:@"shortClose"];
    [_tableView registerClass:[CommentTableViewCell class] forCellReuseIdentifier:@"longClose"];
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (_longCommentModel.comments.count) {
            if (indexPath.row > 0) {
                float height = _longCommentHeightArray[indexPath.row - 1].height;
                return height + 95;
            }
        }
        
    } else {
        if (_shortCommentModel.comments.count) {
            if (indexPath.row > 0) {
                float height = _shortCommentHeightArray[indexPath.row - 1].height;
                return height + 95;
            }
        }
        
    }
    
    return 40;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    if (section == 0) {
        if (_longCommentModel.comments.count) {
            return _longCommentModel.comments.count + 1;
        }
        return _longCommentModel.comments.count;
    } else {
        if (_shortCommentModel.comments.count) {
            return _shortCommentModel.comments.count + 1;
        }
        return _shortCommentModel.comments.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    NSLog(@"height%f", cell.contentView.frame.size.height);
    if (indexPath.row == 0) {
        CommentTableViewCell *cell0 = [tableView dequeueReusableCellWithIdentifier:@"longOrShort" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            cell0.label.text = [NSString stringWithFormat:@"%@条长评", _longCommentNumStr];
    
        } else {
            cell0.label.text = [NSString stringWithFormat:@"%@条短评", _shortCommentNumStr];
            
        }
        return cell0;
    } else if (indexPath.section == 1) {
        
        //短评行数小于3
        if (_shortCommentHeightArray[indexPath.row - 1].lines < 3) {
            
            
            CommentTableViewCell *shortCell = [tableView dequeueReusableCellWithIdentifier:@"short" forIndexPath:indexPath];
            
            //内容
            NSMutableString *str = [NSMutableString stringWithFormat:@"%@",  [_shortCommentModel.comments[indexPath.row - 1] content]];
            shortCell.contentLabel.numberOfLines = 0;
            if ([_shortCommentModel.comments[indexPath.row - 1] reply_to]) {
                [str appendFormat:@"\n//%@: %@", [[_shortCommentModel.comments[indexPath.row - 1] reply_to] author], [[_shortCommentModel.comments[indexPath.row - 1] reply_to] content]];
            }
            shortCell.contentLabel.text = str;
            
            
            
            //头像
            [shortCell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:[_shortCommentModel.comments[indexPath.row - 1] avatar]]];
            shortCell.avatarImageView.layer.cornerRadius = 35 / 2;
            
            //名字
            shortCell.authorLabel.text = [_shortCommentModel.comments[indexPath.row - 1] author];
            

            //点赞
            if (shortCell.likeButton.selected == NO) {
                [shortCell.likeButton setImage:[UIImage imageNamed:@"zan1"] forState:UIControlStateNormal];
                
                if (![[_shortCommentModel.comments[indexPath.row - 1] likes] isEqualToString:@"0"]) {
                    shortCell.likeLabel.text = [NSString stringWithString:[_shortCommentModel.comments[indexPath.row - 1] likes]];
                } else {
                    shortCell.likeLabel.text = @"";
                }
                
            } else {
                [shortCell.likeButton setImage:[UIImage imageNamed:@"zan1-2"] forState:UIControlStateNormal];
                
                if (![[_shortCommentModel.comments[indexPath.row - 1] likes] isEqualToString:@"0"]) {
                    NSString *likeNumber = [NSString stringWithString:[_shortCommentModel.comments[indexPath.row - 1] likes]];
                    
                    shortCell.likeLabel.text = [NSString stringWithFormat:@"%d", [likeNumber intValue] + 1];
                } else {
                    shortCell.likeLabel.text = @"1";
                }
            
            }
            
            [shortCell.likeButton addTarget:self action:@selector(pressLike:) forControlEvents:UIControlEventTouchUpInside];
            
            
            //评论
            [shortCell.commentButton setImage:[UIImage imageNamed:@"pinglun-6"] forState:UIControlStateNormal];
            
            //更多
            [shortCell.moreButton setImage:[UIImage imageNamed:@"gengduo"] forState:UIControlStateNormal];
            

            
            //时间
            //时间戳转换成时间
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[_shortCommentModel.comments[indexPath.row - 1] time] doubleValue]];
            NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
            [dateformatter setDateFormat:@"MM-dd HH:mm"];
            
            shortCell.timeLabel.text = [dateformatter stringFromDate:date];
            
            
            return shortCell;
            
            } else {
            
            
            CommentTableViewCell *shortCell = [tableView dequeueReusableCellWithIdentifier:@"shortClose" forIndexPath:indexPath];
            
            //内容
            NSMutableString *str = [NSMutableString stringWithFormat:@"%@",  [_shortCommentModel.comments[indexPath.row - 1] content]];
            shortCell.contentLabel.numberOfLines = 0;
            if ([_shortCommentModel.comments[indexPath.row - 1] reply_to]) {
                [str appendFormat:@"\n//%@: %@", [[_shortCommentModel.comments[indexPath.row - 1] reply_to] author], [[_shortCommentModel.comments[indexPath.row - 1] reply_to] content]];
            }
            shortCell.contentLabel.text = str;
            
            //头像
            [shortCell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:[_shortCommentModel.comments[indexPath.row - 1] avatar]]];
            shortCell.avatarImageView.layer.cornerRadius = 35 / 2;
            
            //名字
            shortCell.authorLabel.text = [_shortCommentModel.comments[indexPath.row - 1] author];
            

            //点赞
                if (shortCell.likeButton.selected == NO) {
                [shortCell.likeButton setImage:[UIImage imageNamed:@"zan1"] forState:UIControlStateNormal];
                
                if (![[_shortCommentModel.comments[indexPath.row - 1] likes] isEqualToString:@"0"]) {
                    shortCell.likeLabel.text = [NSString stringWithString:[_shortCommentModel.comments[indexPath.row - 1] likes]];
                } else {
                    shortCell.likeLabel.text = @"";
                }
                
            } else {
                [shortCell.likeButton setImage:[UIImage imageNamed:@"zan1-2"] forState:UIControlStateNormal];
                
                if (![[_shortCommentModel.comments[indexPath.row - 1] likes] isEqualToString:@"0"]) {
                    NSString *likeNumber = [NSString stringWithString:[_shortCommentModel.comments[indexPath.row - 1] likes]];
                    
                    shortCell.likeLabel.text = [NSString stringWithFormat:@"%d", [likeNumber intValue] + 1];
                } else {
                    shortCell.likeLabel.text = @"1";
                }
                

            }
            
            [shortCell.likeButton addTarget:self action:@selector(pressLike:) forControlEvents:UIControlEventTouchUpInside];
            
            //评论
            [shortCell.commentButton setImage:[UIImage imageNamed:@"pinglun-6"] forState:UIControlStateNormal];
            
            //更多
            [shortCell.moreButton setImage:[UIImage imageNamed:@"gengduo"] forState:UIControlStateNormal];
            
            //展开
            shortCell.spreadButton.tintColor = [UIColor colorWithWhite:0.6 alpha:1];
            shortCell.spreadButton.titleLabel.font = [UIFont systemFontOfSize:14];
            shortCell.spreadButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
           
            if (_shortCommentHeightArray[indexPath.row - 1].status == 0) {
                shortCell.contentLabel.numberOfLines = 2;
                [shortCell.spreadButton setTitle:@"展开全文" forState:UIControlStateNormal];
            } else {
                shortCell.contentLabel.numberOfLines = 0;
                [shortCell.spreadButton setTitle:@"收起" forState:UIControlStateNormal];
            }
            
            NSString *tagStr = [NSString stringWithFormat:@"%ld",  (long)indexPath.row];
            shortCell.spreadButton.tag = [tagStr intValue];
                
            [shortCell.spreadButton addTarget:self action:@selector(pressShortOpenOrClose:) forControlEvents:UIControlEventTouchUpInside];
            
            
                
            //时间
            //时间戳转换成时间
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[_shortCommentModel.comments[indexPath.row - 1] time] doubleValue]];
            NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
            [dateformatter setDateFormat:@"MM-dd HH:mm"];
            
            shortCell.timeLabel.text = [dateformatter stringFromDate:date];
            
            return shortCell;
        }
            
    } else if (indexPath.section == 0 && _longCommentHeightArray[indexPath.row - 1]) {
        
        if (_longCommentHeightArray[indexPath.row - 1].lines > 2) {
            
            CommentTableViewCell *longCell = [tableView dequeueReusableCellWithIdentifier:@"longClose" forIndexPath:indexPath];
                 
            //内容
            longCell.contentLabel.text = [_longCommentModel.comments[indexPath.row - 1] content];
            longCell.contentLabel.numberOfLines = 0;
                
            //头像
            [longCell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:[_longCommentModel.comments[indexPath.row - 1] avatar]]];
            longCell.avatarImageView.layer.cornerRadius = 35 / 2;
            
            //名字
            longCell.authorLabel.text = [_longCommentModel.comments[indexPath.row - 1] author];
            


            //点赞
            if (longCell.likeButton.selected == NO) {
                [longCell.likeButton setImage:[UIImage imageNamed:@"zan1"] forState:UIControlStateNormal];
                if (![[_longCommentModel.comments[indexPath.row - 1] likes] isEqualToString:@"0"]) {
                    longCell.likeLabel.text = [NSString stringWithString:[_longCommentModel.comments[indexPath.row - 1] likes]];
                } else {
                    longCell.likeLabel.text = @"";
                }
            
            } else {
                [longCell.likeButton setImage:[UIImage imageNamed:@"zan1-2"] forState:UIControlStateNormal];
                //点赞数
                if (![[_longCommentModel.comments[indexPath.row - 1] likes] isEqualToString:@"0"]) {
                    NSString *likeNumber = [NSString stringWithString:[_longCommentModel.comments[indexPath.row - 1] likes]];
                    
                    longCell.likeLabel.text = [NSString stringWithFormat:@"%d", [likeNumber intValue] + 1];
                } else {
                    longCell.likeLabel.text = @"1";
                }
            }
            [longCell.likeButton addTarget:self action:@selector(pressLike:) forControlEvents:UIControlEventTouchUpInside];
            
            
            //评论
            [longCell.commentButton setImage:[UIImage imageNamed:@"pinglun-6"] forState:UIControlStateNormal];
            
            //更多
            [longCell.moreButton setImage:[UIImage imageNamed:@"gengduo"] forState:UIControlStateNormal];
            
            
            
            
            
            longCell.spreadButton.tintColor = [UIColor colorWithWhite:0.6 alpha:1];
            longCell.spreadButton.titleLabel.font = [UIFont systemFontOfSize:14];
            longCell.spreadButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            
             if (_longCommentHeightArray[indexPath.row - 1].status == 0) {
                longCell.contentLabel.numberOfLines = 2;
                 [longCell.spreadButton setTitle:@"展开全文" forState:UIControlStateNormal];
             } else {
                 longCell.contentLabel.numberOfLines = 0;
                 [longCell.spreadButton setTitle:@"收起" forState:UIControlStateNormal];
             }
             
             NSString *tagStr = [NSString stringWithFormat:@"%ld",  (long)indexPath.row];
             longCell.spreadButton.tag = [tagStr intValue];
                 
             [longCell.spreadButton addTarget:self action:@selector(pressLongOpenOrClose:) forControlEvents:UIControlEventTouchUpInside];
             
            
            
            //时间
            //时间戳转换成时间
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[_longCommentModel.comments[indexPath.row - 1] time] doubleValue]];
            NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
            [dateformatter setDateFormat:@"MM-dd HH:mm"];
            
            longCell.timeLabel.text = [dateformatter stringFromDate:date];
            
            
            return longCell;
        }
        
        
    }
    
    return cell;
    
}


- (void)pressShortOpenOrClose:(UIButton *)button {
    if (_shortCommentHeightArray[button.tag - 1].status == 0) {
        _shortCommentHeightArray[button.tag - 1].height = _shortCommentHeightArray[button.tag - 1].openCommentHeight;
        _shortCommentHeightArray[button.tag - 1].status = 1;
        
        [_tableView reloadData];
    } else {
        _shortCommentHeightArray[button.tag - 1].height = _shortCommentHeightArray[button.tag - 1].closeCommentHeight;
        _shortCommentHeightArray[button.tag - 1].status = 0;
      
        [_tableView reloadData];
    }
}


- (void)pressLongOpenOrClose:(UIButton *)button {
    if (_longCommentHeightArray[button.tag - 1].status == 0) {
        _longCommentHeightArray[button.tag - 1].height = _longCommentHeightArray[button.tag - 1].openCommentHeight;
        _longCommentHeightArray[button.tag - 1].status = 1;
        
        [_tableView reloadData];
    } else {
        _longCommentHeightArray[button.tag - 1].height = _longCommentHeightArray[button.tag - 1].closeCommentHeight;
        _longCommentHeightArray[button.tag - 1].status = 0;
      
        [_tableView reloadData];
    }
}


- (void)pressLike:(UIButton *)button {
    if (button.selected == NO) {

        button.selected = YES;
        [_tableView reloadData];
    } else {

        button.selected = NO;
        [_tableView reloadData];
    }
    
}
 
@end

//
//  CommentHeightModel.h
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/11/12.
//  Copyright © 2020 房彤. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentHeightModel : NSObject

@property float openCommentHeight;
@property float closeCommentHeight;
@property float height;
@property int status;
@property int lines;

@end

@interface CommentLikeModel : NSObject

@property NSInteger select;


@end

NS_ASSUME_NONNULL_END

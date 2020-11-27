//
//  ShortCommentModel.h
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/11/5.
//  Copyright © 2020 房彤. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SubShortCommentModel

@end

@protocol ReplyModel

@end

@interface ShortCommentModel : JSONModel

@property NSMutableArray<SubShortCommentModel> *comments;

@end


@interface ReplyModel : JSONModel

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *author;

@end



@interface SubShortCommentModel : JSONModel

@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, strong) ReplyModel *reply_to;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *likes;

@end




NS_ASSUME_NONNULL_END

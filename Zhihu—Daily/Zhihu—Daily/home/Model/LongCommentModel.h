//
//  LongCommentModel.h
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/11/5.
//  Copyright © 2020 房彤. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SubLongCommentModel


@end


@interface LongCommentModel : JSONModel

@property NSMutableArray<SubLongCommentModel>* comments;

@end


@interface SubLongCommentModel : JSONModel

@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *likes;

@end

NS_ASSUME_NONNULL_END

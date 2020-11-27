//
//  Manager.h
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/10/17.
//  Copyright © 2020 房彤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomepageModel.h"
#import "BeforeNewsModel.h"
#import "ExtraModel.h"
#import "LongCommentModel.h"
#import "ShortCommentModel.h"

typedef void (^zhihuLatestBlock)(HomepageModel * _Nullable homepageModel);
typedef void (^errorBlock)(NSError * _Nonnull error);

typedef void (^BeforeNewsBlock)(BeforeNewsModel * _Nullable beforeNewsModel);

typedef void (^ExtraBlock)(ExtraModel * _Nullable extraModel);

typedef void (^LongCommentBlock)(LongCommentModel * _Nullable longCommentModel);

typedef void (^ShortCommentBlock)(ShortCommentModel * _Nullable shortCommentModel);


NS_ASSUME_NONNULL_BEGIN

@interface Manager : NSObject  <NSURLSessionDelegate>

+ (instancetype)shareManager;

- (void)getModelSucceed:(zhihuLatestBlock)succeedBlock error:(errorBlock)errorblock;

- (void)getBeforeNewsModel:(BeforeNewsBlock)succeedBlock error:(errorBlock)errorblock urlStr:(NSString *)urlstr;
//- (void)getBeforeNewsModel:(BeforeNewsBlock)succeedBlock error:(errorBlock)errorblock;

- (void)getExtraModel:(ExtraBlock)succeedBlock error:(errorBlock)errorblock ID:(NSString *)IDstr;

- (void)getLongCommentModel:(LongCommentBlock)succeedBlock error:(errorBlock)errorblock ID:(NSString *)idStr;

- (void)getShortCommentModel:(ShortCommentBlock)succeedBlock error:(errorBlock)errorblock ID:(NSString *)idStr;


@end

NS_ASSUME_NONNULL_END

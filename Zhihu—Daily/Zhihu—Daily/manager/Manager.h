//
//  Manager.h
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/10/17.
//  Copyright © 2020 房彤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomepageModel.h"
typedef void (^zhihuLatestBlock)(HomepageModel * _Nullable homepageModel);
typedef void (^errorBlock)(NSError * _Nonnull error);

NS_ASSUME_NONNULL_BEGIN

@interface Manager : NSObject

+ (instancetype)shareManager;

- (void)getModelSucceed:(zhihuLatestBlock)succeedBlock error:(errorBlock)errorblock;


@end

NS_ASSUME_NONNULL_END

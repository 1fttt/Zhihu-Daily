//
//  ExtraModel.h
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/10/27.
//  Copyright © 2020 房彤. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ExtraModel : JSONModel

@property (nonatomic, assign) NSInteger long_comments;
@property NSInteger popularity;
@property NSInteger short_comments;
@property NSInteger comments;
@property (nonatomic, copy) NSString *cc;
@end

NS_ASSUME_NONNULL_END

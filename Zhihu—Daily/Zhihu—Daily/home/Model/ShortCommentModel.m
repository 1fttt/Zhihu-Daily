//
//  ShortCommentModel.m
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/11/5.
//  Copyright © 2020 房彤. All rights reserved.
//

#import "ShortCommentModel.h"

@implementation ShortCommentModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end




@implementation SubShortCommentModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"ID":@"id"}];
}

@end



@implementation ReplyModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"ID":@"id"}];
}

@end

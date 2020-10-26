//
//  BeforeNewsModel.m
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/10/26.
//  Copyright © 2020 房彤. All rights reserved.
//

#import "BeforeNewsModel.h"

@implementation BeforeNewsModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end

@implementation StoriesModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"ID":@"id"}];
}


@end

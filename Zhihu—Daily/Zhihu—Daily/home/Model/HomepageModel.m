//
//  HomepageModel.m
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/10/17.
//  Copyright © 2020 房彤. All rights reserved.
//

#import "HomepageModel.h"


@implementation HomepageModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end

@implementation Stories

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"ID":@"id"}];
}


@end


@implementation  Top_stories

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
    
}

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"ID":@"id"}];
}

@end

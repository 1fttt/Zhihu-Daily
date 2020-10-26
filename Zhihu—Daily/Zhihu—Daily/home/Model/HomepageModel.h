//
//  HomepageModel.h
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/10/17.
//  Copyright © 2020 房彤. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol Stories

@end

@protocol Top_stories

@end


@interface HomepageModel : JSONModel

@property NSString *date;
@property NSArray<Stories> *stories;
@property NSArray<Top_stories> *top_stories;

@end


@interface Stories : JSONModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *hint;
@property (nonatomic, copy) NSArray *images;
@property (nonatomic, copy) NSString *ID;

@end


@interface Top_stories : JSONModel

@property (nonatomic, copy) NSString *hint;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *ID;

@end


NS_ASSUME_NONNULL_END

//
//  BeforeNewsModel.h
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/10/26.
//  Copyright © 2020 房彤. All rights reserved.
//

#import "JSONModel.h"

@protocol StoriesModel

@end

NS_ASSUME_NONNULL_BEGIN

@interface StoriesModel :JSONModel

@property (nonatomic, copy) NSString *image_hue;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *hint;
//@property (nonatomic, copy) NSString *ga_prefix;
@property (nonatomic, copy) NSArray *images;
@property (nonatomic, copy) NSString *ID;

@end


@interface BeforeNewsModel : JSONModel

@property (nonatomic, copy) NSString *date;
@property NSArray<StoriesModel>* stories;


@end


NS_ASSUME_NONNULL_END

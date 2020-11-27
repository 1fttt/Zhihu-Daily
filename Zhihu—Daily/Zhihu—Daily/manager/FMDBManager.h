//
//  FMDBManager.h
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/11/19.
//  Copyright © 2020 房彤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMDBManager : NSObject

@property FMDatabase *fmdb;

+ (instancetype)shareManager;

- (void)creatTable;
- (void)insertTitle:(NSString *)titleStr andImage:(NSDate *)imageDate;

- (NSMutableArray *)getTitles;
- (NSMutableArray *)getImageDates;

@end

NS_ASSUME_NONNULL_END

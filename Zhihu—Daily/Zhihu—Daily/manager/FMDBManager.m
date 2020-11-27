//
//  FMDBManager.m
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/11/19.
//  Copyright © 2020 房彤. All rights reserved.
//

#import "FMDBManager.h"

@implementation FMDBManager

FMDBManager *manager = nil;


+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[FMDBManager alloc] init];
        }
    });
    return manager;
}

- (void)creatTable {

    //拼接数据库存放的沙盒路径
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *sqlFilePath = [path stringByAppendingPathComponent:@"story.sqlite"];

    //通过路径创建数据库
    BOOL success = NO;

    _fmdb = [FMDatabase databaseWithPath:sqlFilePath];
    if ([_fmdb open]) {
        [_fmdb executeUpdate:@"CREATE TABLE 'collect_story' ('title' VARCHAR(255), 'image' BLOB)"];
        NSLog(@"建表成功");
        [_fmdb close];
    } else {
        NSLog(@"建表失败");
    }
    

}


- (void)insertTitle:(NSString *)titleStr andImage:(NSDate *)imageDate {
    if ([_fmdb open]) {
        NSLog(@"打开成功");
        NSString *str = @"INSERT INTO collect_story (title,image) VALUES (?,?)";
        BOOL success = [_fmdb executeUpdate:str, titleStr, imageDate];
        if (success) {
            NSLog(@"插入成功");
        }
        [_fmdb close];
    } else {
        NSLog(@"打开失败");
    }
}

- (NSMutableArray *)getTitles {
    NSMutableArray *titlesArray = [[NSMutableArray alloc] init];
    
    if ([_fmdb open]) {
        
        FMResultSet *set = [_fmdb executeQuery:@"SELECT * FROM collect_story"];
        while ([set next]) {
            NSString *title = [set stringForColumn:@"title"];
            NSLog(@"%@", title);
            [titlesArray addObject:title];
    
        }
        [_fmdb close];
    } else {
        NSLog(@"打开失败");
    }
    
    return titlesArray;
}

- (NSMutableArray *)getImageDates {
    NSMutableArray *imagesArray = [[NSMutableArray alloc] init];
    if ([_fmdb open]) {
        FMResultSet *set = [_fmdb executeQuery:@"SELECT * FROM collect_story"];
        while ([set next]) {
            NSData *data = [set dataForColumn:@"image"];
            [imagesArray addObject:data];
        }
        [_fmdb close];
    }
    
    return imagesArray;
}



@end

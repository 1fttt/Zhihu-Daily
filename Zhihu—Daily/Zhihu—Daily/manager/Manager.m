//
//  Manager.m
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/10/17.
//  Copyright © 2020 房彤. All rights reserved.
//

#import "Manager.h"
#import <pthread.h>
@implementation Manager 

static Manager *manager = nil;

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[Manager alloc] init];
        }
    });
    return manager;
}


- (void)getModelSucceed:(zhihuLatestBlock)succeedBlock error:(errorBlock)errorblock {
    NSString *urlStr = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/news/latest"];
    
    
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //创建会话
    NSURLSession *session = [NSURLSession sharedSession];

    
    
    //创建任务
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            id dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@", dictionary);
            HomepageModel *homepageModel = [[HomepageModel alloc] initWithDictionary:dictionary error:&error];
          
            succeedBlock(homepageModel);
            
        } else {
            
        }
    }];
    //启动任务
    [task resume];

}


//之前文章
- (void)getBeforeNewsModel:(BeforeNewsBlock)succeedBlock error:(errorBlock)errorblock urlStr:(NSString *)urlstr {
    
    
    NSString * urlStr = [NSString stringWithFormat:@"https://news.at.zhihu.com/api/4/news/before/%@", urlstr];
    //@"https://news.at.zhihu.com/api/4/news/before/20201026";
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    //创建会话
    //NSURLSession *session = [NSURLSession sharedSession];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    
    //创建任务
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {

            id dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@", dictionary);
               
            BeforeNewsModel *beforeNewsModel = [[BeforeNewsModel alloc] initWithDictionary:dictionary error:&error];
                
            succeedBlock(beforeNewsModel);

        } else {
            NSLog(@"error");
        }
    }];

    //启动任务
    [task resume];
    
}
//评论点赞数
- (void)getExtraModel:(ExtraBlock)succeedBlock error:(errorBlock)errorblock ID:(NSString *)IDstr {
    
    NSString *urlStr = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/story-extra/%@", IDstr];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
          
        if (error == nil) {
            NSMutableDictionary * dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"%@", dictionary);
            
            [dictionary setObject:IDstr forKey:@"cc"];
            ExtraModel *extraModel = [[ExtraModel alloc] initWithDictionary:dictionary error:&error];
            succeedBlock(extraModel);
        }
       
    }];
    
    [task resume];
    
}

//长评论
- (void)getLongCommentModel:(LongCommentBlock)succeedBlock error:(errorBlock)errorblock ID:(NSString *)idStr {
    NSString *str = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/story/%@/long-comments", idStr];
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            
            id dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            LongCommentModel *longCommentModel = [[LongCommentModel alloc] initWithDictionary:dictionary error:&error];
            
            succeedBlock(longCommentModel);
            
        }
    }];
    
    [task resume];
    
}


//短评论
- (void)getShortCommentModel:(ShortCommentBlock)succeedBlock error:(errorBlock)errorblock ID:(NSString *)idStr {
    
    NSString *str = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/story/%@/short-comments", idStr];
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        id dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        ShortCommentModel *shortCommentModel = [[ShortCommentModel alloc] initWithDictionary:dictionary error:&error];
        
        succeedBlock(shortCommentModel);
        
    }];
    
    [task resume];
    
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
    NSURLCredential *card = [[NSURLCredential alloc] initWithTrust:challenge.protectionSpace.serverTrust];
    completionHandler(NSURLSessionAuthChallengeUseCredential,card);
}



@end

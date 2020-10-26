//
//  Manager.m
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/10/17.
//  Copyright © 2020 房彤. All rights reserved.
//

#import "Manager.h"

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

- (void)getBeforeNewsModel:(BeforeNewsBlock)succeedBlock error:(errorBlock)errorblock {
//- (void)getBeforeNewsModel:(BeforeNewsBlock)succeedBlock error:(errorBlock)errorblock urlStr:(NSString *)urlstr {
    
    
    NSString * urlStr = @"https://news.at.zhihu.com/api/4/news/before/20201026";
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

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
    NSURLCredential *card = [[NSURLCredential alloc] initWithTrust:challenge.protectionSpace.serverTrust];
    completionHandler(NSURLSessionAuthChallengeUseCredential,card);
}



@end

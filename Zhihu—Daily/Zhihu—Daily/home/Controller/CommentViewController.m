//
//  CommentViewController.m
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/10/27.
//  Copyright © 2020 房彤. All rights reserved.
//

#import "CommentViewController.h"
#import "LongCommentModel.h"
#import "ShortCommentModel.h"
#import "Manager.h"
#import "FMDBManager.h"

@interface CommentViewController ()

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = [NSString stringWithFormat:@"%@条评论", _commentNumStr];
    _commentView = [[CommentView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    [self.view addSubview:_commentView];
    _commentView.idstr = _idstr;
    _commentView.longCommentNumStr = _longCommentNumStr;
    _commentView.shortCommentNumStr = _shortCommentNumStr;
    [_commentView initView];
    
    //self.navigationItem.hidesBackButton = YES;
    

    
}



- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //[self.navigationItem setHidesBackButton:NO];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

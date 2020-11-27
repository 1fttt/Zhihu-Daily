//
//  CommentViewController.h
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/10/27.
//  Copyright © 2020 房彤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentView.h"


NS_ASSUME_NONNULL_BEGIN

@interface CommentViewController : UIViewController

@property (nonatomic, copy) NSString *idstr;
@property (nonatomic, copy) NSString *longCommentNumStr;
@property (nonatomic, copy) NSString *shortCommentNumStr;
@property (nonatomic, copy) NSString *commentNumStr;

@property (nonatomic, strong) CommentView *commentView;


@end

NS_ASSUME_NONNULL_END

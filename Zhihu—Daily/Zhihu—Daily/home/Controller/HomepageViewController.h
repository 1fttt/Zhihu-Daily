//
//  HomepageViewController.h
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/10/16.
//  Copyright © 2020 房彤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomepageView.h"
#import "HomepageModel.h"
#import "ExtraModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomepageViewController : UIViewController

@property (nonatomic, strong) HomepageView *homeView;
@property (nonatomic, copy) ExtraModel *extraModelArray;
@end

NS_ASSUME_NONNULL_END

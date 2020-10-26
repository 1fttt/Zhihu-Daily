//
//  MypageView.m
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/10/18.
//  Copyright © 2020 房彤. All rights reserved.
//

#import "MypageView.h"

@implementation MypageView

- (void)initView {
    self.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 84, self.frame.size.width, 313) style:UITableViewStylePlain];
    [self addSubview:_tableView];
    _tableView.backgroundColor = [UIColor whiteColor];
    
    _modeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_modeButton];
    _modeButton.frame = CGRectMake(self.frame.size.width / 2 - 140, 690, 90, 90);
    [_modeButton setImage:[UIImage imageNamed:@"yejianmoshi"] forState:UIControlStateNormal];
    

    
    
    _setButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_setButton];
    _setButton.frame = CGRectMake(self.frame.size.width / 2 + 72, 690, 90, 90);
    [_setButton setImage:[UIImage imageNamed:@"shezhi-2"] forState:UIControlStateNormal];
    
    
}

@end

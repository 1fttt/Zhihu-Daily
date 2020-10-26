//
//  HomepageView.m
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/10/16.
//  Copyright © 2020 房彤. All rights reserved.
//

#import "HomepageView.h"

@implementation HomepageView

- (void)initView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 85, self.frame.size.width, self.frame.size.height - 85) style:UITableViewStylePlain];
    [self addSubview:_tableView];
    _tableView.backgroundColor = [UIColor greenColor];
    
    
}

@end

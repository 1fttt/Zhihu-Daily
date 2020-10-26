//
//  MyViewController.m
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/10/18.
//  Copyright © 2020 房彤. All rights reserved.
//

#import "MyViewController.h"
#import "MypageTableViewCell.h"
#import "MyCollectionViewController.h"
#import "MyInformationViewController.h"

@interface MyViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
}

- (void)addView {
    self.view.backgroundColor = [UIColor whiteColor];
    _myView = [[MypageView alloc] initWithFrame:self.view.frame];
    [_myView initView];
    [self.view addSubview:_myView];
    
    
    self.myView.tableView.delegate = self;
    self.myView.tableView.dataSource = self;
    [self.myView.tableView registerClass:[MypageTableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.myView.tableView registerClass:[MypageTableViewCell class] forCellReuseIdentifier:@"cell2"];
    
    
    [self.myView.modeButton addTarget:self action:@selector(pressMode) forControlEvents:UIControlEventTouchUpInside];
    [self.myView.setButton addTarget:self action:@selector(pressSet) forControlEvents:UIControlEventTouchUpInside];
}

- (void)pressMode {
    
}
- (void)pressSet {
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 170;
    } else {
        return 70;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        MypageTableViewCell *cell = [[MypageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        [cell.headButton setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
        
        cell.nameLabel.text = @"Fttt";
        return cell;
    }
    else {
        MypageTableViewCell *cell = [[MypageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        NSArray *array = @[@"我的收藏", @"消息中心"];
        cell.label.text = array[indexPath.row - 1];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        MyCollectionViewController *myColView = [[MyCollectionViewController alloc] init];
        [self.navigationController pushViewController:myColView animated:YES];
    }
    if (indexPath.row == 2) {
        MyInformationViewController *myInfView = [[MyInformationViewController alloc] init];
        [self.navigationController pushViewController:myInfView animated:YES];
    }
}



@end

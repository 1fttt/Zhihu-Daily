//
//  MyCollectionViewController.m
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/10/18.
//  Copyright © 2020 房彤. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "MyCollectionView.h"

@interface MyCollectionViewController ()

@end

@implementation MyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _myView = [[MyCollectionView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_myView];
    [_myView initView];
    _myView.backgroundColor = [UIColor redColor];
    
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

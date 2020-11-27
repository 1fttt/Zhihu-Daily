//
//  MyCollectionView.m
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/11/20.
//  Copyright © 2020 房彤. All rights reserved.
//

#import "MyCollectionView.h"
#import "FMDBManager.h"

@implementation MyCollectionView 

- (void)initView {
    _tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    [self addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    FMDBManager *manager = [FMDBManager shareManager];
    _titleArray = [manager getTitles];
    _imageArray = [manager getImageDates];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.textLabel.numberOfLines = 2;
    cell.imageView.image = [UIImage imageWithData: _imageArray[indexPath.row] ];
    return cell;
    
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"delete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        
        FMDBManager *manager = [FMDBManager shareManager];
        if ([manager.fmdb open]) {
            [manager.fmdb executeUpdate:[NSString stringWithFormat:@"delete from collect_story where title = '%@'", _titleArray[indexPath.row]]] ;
            [manager.fmdb close];
        }
        
        [_titleArray removeObjectAtIndex:indexPath.row];
        completionHandler (YES);
        [self.tableView reloadData];
    }];
    deleteRowAction.image = [UIImage imageNamed:@"删除"];
    deleteRowAction.backgroundColor = [UIColor colorWithRed:0.8 green:0.1 blue:0.1 alpha:1];
    
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
    return config;

}

@end

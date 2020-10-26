//
//  MypageTableViewCell.m
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/10/18.
//  Copyright © 2020 房彤. All rights reserved.
//

#import "MypageTableViewCell.h"
#import "Masonry.h"

@implementation MypageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ([self.reuseIdentifier isEqualToString:@"cell1"]) {
        _headButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _headButton.frame = CGRectMake(self.frame.size.width / 2 , 20, 90, 90);
        _headButton.layer.cornerRadius = 50;
        [self.contentView addSubview:_headButton];
//        _headButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self.mas_centerX);
//            make.top.mas_offset(self.mas_top - 70);
//
//        }
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.frame = CGRectMake(190, 125, 80, 40);
        _nameLabel.font = [UIFont systemFontOfSize:23];
        [self.contentView addSubview:_nameLabel];
    } else {
        _label = [[UILabel alloc] init];
        [self.contentView addSubview:_label];
        _label.frame = CGRectMake(20, 10, 100, 40);
    }
    return self;
}



@end

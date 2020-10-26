//
//  HomepageTableViewCell.m
//  Zhihu—Daily
//
//  Created by 房彤 on 2020/10/18.
//  Copyright © 2020 房彤. All rights reserved.
//

#import "HomepageTableViewCell.h"
//#import "UIImageView+WebCache.h"

@implementation HomepageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ([self.reuseIdentifier isEqualToString:@"homecell1"]) {
        _titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
        
        _hintLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_hintLabel];
        
        _imageview = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageview];
    } else {
        
    }
    return self;
}

- (void)layoutSubviews {
    _titleLabel.frame = CGRectMake(20, 30, 280, 30);
    _hintLabel.frame = CGRectMake(20, 60, 200, 20);
    _imageview.frame = CGRectMake(300, 15, 80, 80);
}

@end

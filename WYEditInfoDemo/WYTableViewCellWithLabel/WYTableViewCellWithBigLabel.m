//
//  WYTableViewCellWithBigLabel.m
//  WYEditInfoDemo
//
//  Created by 意一yiyi on 2017/3/8.
//  Copyright © 2017年 意一yiyi. All rights reserved.
//

#import "WYTableViewCellWithBigLabel.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation WYTableViewCellWithBigLabel

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        [self drawView];
    }
    
    return self;
}


#pragma mark - drawView

- (void)drawView {
    
    [self addSubview:self.accessoryLabel];
}


#pragma mark - 懒加载

- (UILabel *)accessoryLabel {
    
    if (!_accessoryLabel) {
        
        _accessoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, kScreenWidth - 30 - 100, 88)];
        _accessoryLabel.backgroundColor = [UIColor clearColor];
        
        _accessoryLabel.textAlignment = NSTextAlignmentRight;
        _accessoryLabel.numberOfLines = 0;
        
        _accessoryLabel.font = [UIFont systemFontOfSize:14];
        _accessoryLabel.textColor = [UIColor colorWithRed:108 / 255.0 green:108 / 255.0 blue:108 / 255.0 alpha:1];
    }
    
    return _accessoryLabel;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

//
//  WYTableViewCellWithBigImageView.m
//  WYEditInfoDemo
//
//  Created by 意一yiyi on 2017/3/8.
//  Copyright © 2017年 意一yiyi. All rights reserved.
//

#import "WYTableViewCellWithBigImageView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation WYTableViewCellWithBigImageView

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
    
    [self addSubview:self.accessoryImageView];
}


#pragma mark - 懒加载

- (UIImageView *)accessoryImageView {
    
    if (!_accessoryImageView) {
        
        _accessoryImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 30 - 60, 14, 60, 60)];
        _accessoryImageView.backgroundColor = [UIColor clearColor];
        
        _accessoryImageView.layer.cornerRadius = 30;
        _accessoryImageView.layer.masksToBounds = YES;
        
        _accessoryImageView.userInteractionEnabled = NO;
    }
    
    return _accessoryImageView;
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

//
//  FHFamousDoctorButton.m
//  FastHealing
//
//  Created by ZhangZiang on 16/1/21.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHFamousDoctorButton.h"
#import "Masonry.h"

@interface FHFamousDoctorButton ()

@property (nonatomic, weak) UIImageView *iconView;

@property (nonatomic, weak) UILabel *nameLabel;

@end

@implementation FHFamousDoctorButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *iconView = [[UIImageView alloc]init];
        
        self.iconView = iconView;
        
        [self addSubview:iconView];
        
        UILabel *nameLabel = [[UILabel alloc]init];
        
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.textColor = [UIColor colorWithWhite:0.4 alpha:1];
        
        self.nameLabel = nameLabel;
        
        [self addSubview:nameLabel];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat margin = FHScreenSize.height*0.02;
    //设置约束
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.top.equalTo(self);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.iconView.mas_bottom).with.offset(margin);
    }];
}

- (void)setButtonTag:(NSInteger)buttonTag {
    _buttonTag = buttonTag;
    
    NSString *typeName = @"";
    //设置图片 骨科颜色
    UIImage *btnImage = [UIImage imageNamed:[NSString stringWithFormat:@"famousDoctorColor_%ld",buttonTag+1]];
    
    
    self.iconView.image = btnImage;
    
    switch (buttonTag+1) {
        case 1:
            typeName = @"肿瘤";
            break;
        case 2:
            typeName = @"血液科";
            break;
        case 3:
            typeName = @"心血管";
            break;
        case 4:
            typeName = @"神经科";
            break;
        case 5:
            typeName = @"骨科";
            break;
        case 6:
            typeName = @"公益活动";
            break;
        default:
            break;
    }
    
    self.nameLabel.text = typeName;

}

@end

//
//  FHCNChildFoundationButton.m
//  FastHealing
//
//  Created by 王 on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHCNChildFoundationButton.h"

#define marginOfImageAndLabel 5

@implementation FHCNChildFoundationButton



- (instancetype)buttonWithImageAboveTitleDown:(UIImage *)image title:(NSString *)title {

    [self setImage:image forState:UIControlStateNormal];
    self.contentMode = UIViewContentModeScaleToFill;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    [self setTitle:title forState:UIControlStateNormal];
    
    return self;
    
    
}

//将按钮设置成上下的布局模式
-(void)layoutSubviews {

    [super layoutSubviews];
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.height * 0.7;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame) + marginOfImageAndLabel;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height * 0.2;
}

//取消点击的highlight状态
-(void)setHighlighted:(BOOL)highlighted {
    
}

@end

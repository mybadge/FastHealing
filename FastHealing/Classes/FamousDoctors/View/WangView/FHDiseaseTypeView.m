//
//  FHDiseaseTypeView.m
//  FastHealing
//
//  Created by 王 on 16/1/24.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHDiseaseTypeView.h"
#import "Masonry.h"

@interface FHDiseaseTypeView ()

@property (strong, nonatomic) UIButton *lastSelectBtn;

@end

@implementation FHDiseaseTypeView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //设置布局
        [self decorateUI];
    }
    return self;
}


//设置布局
- (void)decorateUI {
    //创建左侧label
    UILabel *diseaseTypeLabel = [[UILabel alloc]init];
    diseaseTypeLabel.text = @"病因类型:";
    [self addSubview:diseaseTypeLabel];
    //创建右侧的button
    UIButton *parent = [self addButton:@"父母因素" btnTag:100];
    UIButton *childbirth = [self addButton:@"产时因素" btnTag:110];
    UIButton *afterChildBirth = [self addButton:@"产后因素" btnTag:120];
    
    //默认第一个按钮选中状态
    [self diseaseTypeButtonClick:parent];

    
    
    
    //设置约束
    [diseaseTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(5);
        make.left.equalTo(self.mas_left);
    }];
    
    [parent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(diseaseTypeLabel.mas_right).offset(10);
        make.width.mas_equalTo(FHScreenSize.width * 0.2);
    }];
    [childbirth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(parent.mas_top);
        make.left.equalTo(parent.mas_right);
        make.width.equalTo(parent.mas_width);
    }];
    [afterChildBirth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(parent.mas_top);
        make.left.equalTo(childbirth.mas_right);
        make.width.equalTo(parent.mas_width);
    }];
}


//挨个创建button
- (UIButton *)addButton:(NSString *)title btnTag:(CGFloat)tagNumber {
    UIButton *btn = [[UIButton alloc]init];
    btn.tag = tagNumber;
    [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setTitleColor:FHPublicBenefitColor forState:UIControlStateSelected];

    btn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    btn.layer.borderWidth = 1;
    
    [btn addTarget:self action:@selector(diseaseTypeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
    
    return btn;
}

//button的点击事件
- (void)diseaseTypeButtonClick:(UIButton *)sender {
    self.lastSelectBtn.selected = !self.lastSelectBtn.selected;
    sender.selected = !sender.selected;
    self.lastSelectBtn = sender;
//    NSLog(@"%ld",sender.tag);
    
    if ([self.delegate respondsToSelector:@selector(diseaseTypeView:clickButton:)]) {
        [self.delegate diseaseTypeView:self clickButton:sender];
    }
}

@end

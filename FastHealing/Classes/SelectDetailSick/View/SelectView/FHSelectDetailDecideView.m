//
//  FHSelectDetailDecideView.m
//  FastHealing
//
//  Created by ZhangZiang on 16/1/21.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHSelectDetailDecideView.h"
#import "Masonry.h"
#import "SVProgressHUD.h"

#define doctorNumAttFontSize 45

@interface FHSelectDetailDecideView ()

@property (nonatomic, weak) UILabel *infoLabel;

@property (nonatomic, weak) UILabel *doctorNumLabel;

@property (nonatomic, weak) UIImageView *doctorIcon;

@property (nonatomic, weak) UIButton *decideBtn;

@end

@implementation FHSelectDetailDecideView

- (void)decideBtnClicked {
    
    if (self.doctorNum > 0 && (self.hasTreatMethod == NO || (self.hasTreatMethod == YES && self.treatMethod > 0))) {
        if (self.blockClicked) {
            self.blockClicked();
        }
    } else if (self.doctorNum > 0 && self.treatMethod == 0) {
        [SVProgressHUD showInfoWithStatus:@"请选择治疗方式"];
    }
    else {
        [SVProgressHUD showInfoWithStatus:@"请先选择疾病细分"];
    }
    
}

- (void)setDoctorNum:(NSInteger)doctorNum {
    _doctorNum = doctorNum;
    
    self.doctorNumLabel.text = [NSString stringWithFormat:@"%ld位",doctorNum];
    //设置文本不一样大
    NSMutableAttributedString *doctorNumAttStr = [[NSMutableAttributedString alloc]initWithString:self.doctorNumLabel.text];
    [doctorNumAttStr setAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:doctorNumAttFontSize]} range:NSMakeRange(0, self.doctorNumLabel.text.length-1)];
    self.doctorNumLabel.attributedText = doctorNumAttStr;
    
//    self.decideBtn.backgroundColor = doctorNum > 0 ? [UIColor cyanColor] : [UIColor lightGrayColor];
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1];
    
    UILabel *infoLabel = [[UILabel alloc]init];
    
    infoLabel.textColor = [UIColor lightGrayColor];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    
    infoLabel.text = @"重庆诊所为您匹配到";
    infoLabel.font = [UIFont systemFontOfSize:15];
    self.infoLabel = infoLabel;
    
    UILabel *doctorNumLabel = [[UILabel alloc]init];
    
    doctorNumLabel.textColor = FHPublicBenefitColor;
    doctorNumLabel.textAlignment = NSTextAlignmentCenter;
    doctorNumLabel.font = [UIFont systemFontOfSize:15];
    doctorNumLabel.text = @"0位";
    
    self.doctorNumLabel = doctorNumLabel;
    
    //设置文本不一样大
    NSMutableAttributedString *doctorNumAttStr = [[NSMutableAttributedString alloc]initWithString:doctorNumLabel.text];
    [doctorNumAttStr setAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:doctorNumAttFontSize]} range:NSMakeRange(0, doctorNumLabel.text.length-1)];
    doctorNumLabel.attributedText = doctorNumAttStr;
    
    
    UIImageView *doctorIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"doctor_default"]];
    
    self.doctorIcon = doctorIcon;
    
    UIButton *decideBtn = [[UIButton alloc]init];
    
    [decideBtn setTitle:@"就诊申请" forState:UIControlStateNormal];
    [decideBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    decideBtn.backgroundColor = FHPublicBenefitColor;
    
    [decideBtn addTarget:self action:@selector(decideBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.decideBtn = decideBtn;
    
    [self addSubview:infoLabel];
    [self addSubview:doctorIcon];
    [self addSubview:doctorNumLabel];
    [self addSubview:decideBtn];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat margin = FHScreenSize.height*0.015;
    
    //添加约束...
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self);
    }];
    
    [self.doctorNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.infoLabel);
        make.top.equalTo(self.infoLabel.mas_bottom).with.offset(margin);
    }];
    
    [self.doctorIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.infoLabel);
        make.width.height.mas_equalTo(FHScreenSize.height*0.11);
        make.top.equalTo(self.doctorNumLabel.mas_bottom).with.offset(margin);
    }];
    
    [self.decideBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.infoLabel);
        make.top.equalTo(self.doctorIcon.mas_bottom).with.offset(2*margin);
        make.left.equalTo(self).with.offset(margin);
        make.right.equalTo(self).with.offset(-margin);
    }];
}


@end

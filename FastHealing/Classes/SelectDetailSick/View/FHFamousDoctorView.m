//
//  FHFamousDoctorView.m
//  FastHealing
//
//  Created by ZhangZiang on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHFamousDoctorView.h"
#import "FHDetailSelectViewController.h"
#import "Masonry.h"
#import "FHFamousDoctorButton.h"
@interface FHFamousDoctorView ()

@property (nonatomic, strong) NSMutableArray *btnArrMu;

@property (nonatomic, strong) NSMutableArray *lines;

@property (nonatomic, weak) UIView *centerLine;

@end

@implementation FHFamousDoctorView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat w = FHScreenSize.width/9;
    CGFloat h = self.bounds.size.height/4;
    
    CGFloat margin = h/2;
    
    CGFloat lineWidth = 0.5;
    CGFloat marginForLine = 10;
    
    //添加约束
    for (int i = 0; i < 6; i++) {
        FHFamousDoctorButton *btn = self.btnArrMu[i];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(w + (i%3)*3*w);
            if (i < 3) {
                make.top.equalTo(self).with.offset(margin-marginForLine);
            }else {
                make.top.equalTo(self).with.offset(margin*3 + h-marginForLine);
            }
            make.height.mas_equalTo(h);
            make.width.mas_equalTo(w);
        }];
    }
    
    [self.centerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(lineWidth);
    }];
    
    for (int i = 0; i < 4; i++) {
        UIView *line = self.lines[i];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(((i%2)+1)*w*3);
            make.width.mas_equalTo(lineWidth);
            if (i < 2) {
                make.top.equalTo(self).with.offset(marginForLine);
                make.bottom.equalTo(self.centerLine.mas_top).with.offset(-marginForLine);
            } else {
                make.top.equalTo(self.centerLine.mas_bottom).with.offset(marginForLine);
                make.bottom.equalTo(self).with.offset(-marginForLine);
            }
        }];
    }
    
}

- (void)btnClicked:(FHFamousDoctorButton *)btn {
    
        if (self.blockClicked) {
            self.blockClicked(btn.buttonTag+1);
        }
    
}


- (void)setupUI {
    
    
    for (int i = 0; i < 6; i++) {
        FHFamousDoctorButton *btn = [[FHFamousDoctorButton alloc]init];
        
        btn.buttonTag = i;
        
        
        [self addSubview:btn];
        
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.btnArrMu addObject:btn];
    }

    for (int i = 0; i < 4; i ++) {
        UIView *line = [[UIView alloc]init];
        
        line.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
        
        [self addSubview:line];
        
        [self.lines addObject:line];
    }
    
    UIView *centerline = [[UIView alloc]init];
    
    self.centerLine = centerline;
    
    centerline.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
    
    [self addSubview:centerline];
    
}

- (NSMutableArray *)btnArrMu {
    if (_btnArrMu == nil) {
        _btnArrMu = [NSMutableArray array];
    }
    return _btnArrMu;
}

- (NSMutableArray *)lines {
    if (_lines == nil) {
        _lines = [NSMutableArray array];
    }
    return _lines;
}

@end

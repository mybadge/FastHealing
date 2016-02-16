//
//  HTFPopupWindow.m
//  PopupWindow
//
//  Created by 赫腾飞 on 16/1/24.
//  Copyright © 2016年 hetefe. All rights reserved.
//

#import "HTFPopupWindow.h"

#import "Masonry.h"

#define LABLE_HEIGHTWIDTH_SCALE 0.5 / 3.1

#define BUTTON_HEIGHTWIDTH_SCALE 1 / 3.1

@interface HTFPopupWindow ()

@property (nonatomic, strong) UIButton *cancleButton;//取消按钮
@property (nonatomic, strong) UIButton *OKButton;//确定按钮
@property (nonatomic, strong) UIView *separatorLineH;//分割线1
@property (nonatomic, strong) UIView *separatorLineW;//分割线2

@end

@implementation HTFPopupWindow

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self setupUI];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.95];
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = NO;
    }
    return self;
}


- (void)setupUI{

    //title
    [self addSubview:self.titleLable];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.offset(self.frame.size.width * LABLE_HEIGHTWIDTH_SCALE);
    }];
    
 
    
    //button
    [self addSubview:self.cancleButton];
    [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.left.equalTo(self);
        make.width.offset((self.frame.size.width - 1)/2.0);
        make.height.multipliedBy(BUTTON_HEIGHTWIDTH_SCALE).equalTo(self.cancleButton.mas_width);
    }];
    
    
    //button
    [self addSubview:self.OKButton];
    [self.OKButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.right.equalTo(self);
        make.width.offset((self.frame.size.width - 1)/2.0);
        make.height.multipliedBy(BUTTON_HEIGHTWIDTH_SCALE).equalTo(self.cancleButton.mas_width);
    }];
    
    //button_button separatorLine
    [self addSubview:self.separatorLineH];
    [self.separatorLineH mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.mas_bottom);
        make.width.offset(0.5);
        make.height.offset((self.frame.size.width - 1) / 2 * BUTTON_HEIGHTWIDTH_SCALE);
        make.centerX.equalTo(self.mas_centerX);
        
    }];
    
    //button_button separatorLine
    [self addSubview:self.separatorLineW];
    [self.separatorLineW mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.cancleButton.mas_top);
        make.height.offset(1);
        make.width.offset(self.frame.size.width);
        make.centerX.equalTo(self.mas_centerX);
        
    }];
    
    //middle_View
    [self addSubview:self.middleView];
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.cancleButton.mas_top);
        make.left.right.equalTo(self);
        make.top.equalTo(self.titleLable.mas_bottom);
        
    }];

    [self.cancleButton addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.OKButton addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)didClickButton:(UIButton *)sender{

    if (self.valueblock) {
        
//        if (sender.tag == 0) {
//            self.OKButton.selected = NO;
//        }if (sender.tag == 1) {
//            self.cancleButton.selected = NO;
//        }
        
        self.valueblock(sender.tag);
    }
}
#pragma mark  懒加载子视图
- (UILabel *)titleLable{

    if (_titleLable == nil) {
        
        _titleLable = [[UILabel alloc] init];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.textColor = [UIColor blueColor];
        _titleLable.font = [UIFont systemFontOfSize:20.0];
        _titleLable.adjustsFontSizeToFitWidth = YES;
        _titleLable.text = _titleLable.text;
        
    }
    return _titleLable;
}
- (UIButton *)cancleButton{
    
    if (_cancleButton == nil) {
        _cancleButton = [[UIButton alloc] init];
        [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleButton setTitleColor:[UIColor colorWithRed:126/255.0 green:202/255.0 blue:207/255.0 alpha:1] forState:UIControlStateSelected];
        [_cancleButton setTitleColor:[UIColor colorWithRed:126/255.0 green:202/255.0 blue:207/255.0 alpha:1] forState:UIControlStateHighlighted];
        _cancleButton.titleLabel.font = [UIFont systemFontOfSize:20];
        [_cancleButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        _cancleButton.tag = 0;
    }
    return _cancleButton;
}

- (UIButton *)OKButton{
    
    if (_OKButton == nil) {
        _OKButton = [[UIButton alloc] init];
        [_OKButton setTitle:@"提交" forState:UIControlStateNormal];
        [_OKButton setTitleColor:[UIColor colorWithRed:126/255.0 green:202/255.0 blue:207/255.0 alpha:1] forState:UIControlStateNormal];
        [_OKButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        _OKButton.titleLabel.font = [UIFont systemFontOfSize:20];
        [_OKButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
        _OKButton.tag = 1;
    }
    return _OKButton;
    
}
- (UIView *)separatorLineH{
    
    if (_separatorLineH == nil) {
        _separatorLineH = [[UIView alloc] init];
        _separatorLineH.backgroundColor = [UIColor blackColor];
        _separatorLineH.alpha = 0.3;
    }
    return _separatorLineH;
}
- (UIView *)separatorLineW{
    
    if (_separatorLineW == nil) {
        _separatorLineW = [[UIView alloc] init];
        _separatorLineW.backgroundColor = [UIColor blackColor];
        _separatorLineW.alpha = 0.3;
    }
    return _separatorLineW;
}

- (UIView *)middleView{

    if (_middleView == nil) {
        _middleView = [[UIView alloc] init];
        _middleView.backgroundColor = [UIColor darkGrayColor];
    }
    return _middleView;
    
}

@end

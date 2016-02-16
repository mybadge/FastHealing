//
//  FHSelectTextView.m
//  dcDemo
//
//  Created by ZhangZiang on 16/1/19.
//  Copyright © 2016年 ZhangZiang. All rights reserved.
//

#import "FHSelectTextView.h"
#import "Masonry.h"
#import "FHSelectTextOptionButton.h"

CGFloat margin = 5;
@interface FHSelectTextView()


@property (nonatomic, weak) FHSelectTextOptionButton *firstBtn;

@property (nonatomic, weak) FHSelectTextOptionButton *secondBtn;

@property (nonatomic, assign) BOOL hasSelectBtn;

@property (nonatomic, weak) UIImageView *arrowView;

@property (nonatomic, weak) UIView *lineView;

@end

@implementation FHSelectTextView
//入口
- (instancetype)initWithPlaceHolder:(NSString *)placeHolderStr {
    
    if (self = [super init]) {
        
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor colorWithWhite:0.91 alpha:1].CGColor;
        
        UILabel *placeHolderLbl = [[UILabel alloc]init];
        
        placeHolderLbl.text = placeHolderStr;
        placeHolderLbl.font = [UIFont systemFontOfSize:15];
        placeHolderLbl.textColor = [UIColor lightGrayColor];
        
        self.placeHolder = placeHolderLbl;
        
        self.placeHolder.frame = CGRectMake(margin, margin, 0, 0);
        
        [self.placeHolder sizeToFit];
        
        [self addSubview:placeHolderLbl];
        
        self.hasSelectBtn = NO;
        //第二栏的总数label
        UILabel *amountLabel = [[UILabel alloc]init];
        
        [self addSubview:amountLabel];
        
        self.amountLabel = amountLabel;
        amountLabel.font = [UIFont systemFontOfSize:15];
        amountLabel.textColor = FHPublicBenefitColor;
        
        amountLabel.hidden = YES;
        
        amountLabel.textAlignment = NSTextAlignmentRight;
        
        //最右边的箭头
        UIImageView *arrow = [[UIImageView alloc]init];
        
        [self addSubview:arrow];
        
        self.arrowView = arrow;
        
        arrow.image = [UIImage imageNamed:@"right"];
        arrow.contentMode = UIViewContentModeScaleAspectFit;
        //创建竖线
        UIView *line = [[UIView alloc]init];
        
        [self addSubview:line];
        
        self.lineView = line;
        
        line.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1];
    };
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self setupUI];
    
    //NSLog(@"%@",NSStringFromCGRect(self.firstBtn.frame));
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    
    //添加约束
    CGFloat margin = 10;
    CGFloat arrowWidth = 0.075*FHScreenSize.width;
    CGFloat amountLabelWidth = 65;
    
    [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self);
        make.width.mas_equalTo(arrowWidth);
        make.height.equalTo(self);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowView.mas_left).offset(2);
        make.width.mas_equalTo(1);
        make.top.equalTo(self).with.offset(margin);
        make.bottom.equalTo(self).with.offset(-margin);
    }];
    
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.lineView.mas_left).with.offset(-margin);
        make.width.mas_equalTo(amountLabelWidth);
    }];
    
    [self.placeHolder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).with.offset(margin);
        make.right.equalTo(self.amountLabel.mas_left);
    }];
    
    //CGFloat moreWidthForBtn = FHScreenSize.width*0.016;
    
    if (self.hasSelectBtn) {
        //Xcode7.2 中这个不好使
        //[self.firstBtn sizeToFit];
        //[self.secondBtn sizeToFit];
        
        [self.secondBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).with.offset(-margin);
            make.centerY.equalTo(self);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(20);
            //make.width.mas_equalTo(self.secondBtn.bounds.size.width + moreWidthForBtn);
        }];
        
        [self.firstBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.secondBtn.mas_left).with.offset(-margin);
            make.centerY.equalTo(self);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(20);
            //make.width.mas_equalTo(self.firstBtn.bounds.size.width + moreWidthForBtn);
        }];
    }
    
}

//创建2个选择button
- (void)createSelectButtonWithFirstString:(NSString *)firstStr secondString:(NSString *)secondStr {
    
    //隐藏箭头
    self.arrowView.hidden = YES;
    self.lineView.hidden = YES;
    
    CGFloat margin = 0.012*FHScreenSize.width;
    
    self.hasSelectBtn = YES;
    
    FHSelectTextOptionButton *firstBtn = [[FHSelectTextOptionButton alloc]init];
    firstBtn.tag = 1;
    [firstBtn setTitle:firstStr forState:UIControlStateNormal];
    [firstBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //设置图片
    [firstBtn setImage:[UIImage imageNamed:@"sick_Unselected"] forState:UIControlStateNormal];
    [firstBtn setImage:[UIImage imageNamed:@"sick_Selected"] forState:UIControlStateSelected];
    
    firstBtn.titleEdgeInsets = UIEdgeInsetsMake(0, margin, 0, 0);
    firstBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    self.firstBtn = firstBtn;
    
    FHSelectTextOptionButton *secondBtn = [[FHSelectTextOptionButton alloc]init];
    secondBtn.tag = 2;
    [secondBtn setTitle:secondStr forState:UIControlStateNormal];
    [secondBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    //设置图片
    [secondBtn setImage:[UIImage imageNamed:@"sick_Unselected"] forState:UIControlStateNormal];
    [secondBtn setImage:[UIImage imageNamed:@"sick_Selected"] forState:UIControlStateSelected];
    
    secondBtn.titleEdgeInsets = UIEdgeInsetsMake(0, margin, 0, 0);
    secondBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    self.secondBtn = secondBtn;
    
    
    [self addSubview:firstBtn];
    [self addSubview:secondBtn];
    
    
    [firstBtn addTarget:self action:@selector(selectBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [secondBtn addTarget:self action:@selector(selectBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)selectBtnClicked:(UIButton *)btn {
    
    if (btn.selected) {
        return;
    }
    
    self.firstBtn.selected = NO;
    self.secondBtn.selected = NO;
    
    btn.selected = YES;
    
    if (self.block) {
        self.block(btn.tag);
    }
}



@end

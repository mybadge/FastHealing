//
//  FHDiseaseBtnChosenCell.m
//  FastHealing
//
//  Created by 王 on 16/1/23.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHDiseaseBtnChosenCell.h"
#import "Masonry.h"

#define TextFrontMargin 2

@interface FHDiseaseBtnChosenCell ()

@property (strong, nonatomic) UIButton *diseaseBtn;
@property (strong, nonatomic) NSMutableArray *diseaseBtnArray;

@end

@implementation FHDiseaseBtnChosenCell

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIButton *diseaseBtn = [[UIButton alloc]init];
        [self addSubview:diseaseBtn];
        diseaseBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        self.diseaseBtn = diseaseBtn;
        [self.diseaseBtnArray addObject:diseaseBtn];
        //配置btn的selected状态
        [diseaseBtn setTitleColor:FHPublicBenefitColor forState:UIControlStateSelected];
        [diseaseBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
        //配置btn的normal状态
        [diseaseBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        //约束
        [diseaseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        diseaseBtn.userInteractionEnabled = NO;
//        [diseaseBtn addTarget:self action:@selector(diseaseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //设置cell边框
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 1;
        
        //设置cell的背景颜色
        self.backgroundColor = FHColor(245, 245, 245);
        

        
    }
    return self;

}

//- (void)diseaseBtnClick:(UIButton *)sender {
//    sender.selected = !sender.selected;
//    NSLog(@"%ld",sender.tag);
//    if ([self.delegate respondsToSelector:@selector(diseaseBtnChosenCell:button:)]) {
//        [self.delegate diseaseBtnChosenCell:self button:sender];
//    }
//}


-(void)layoutSubviews {
    [super layoutSubviews];

    self.diseaseBtn.selected = self.isSelected;

}

-(void)setTitle:(NSString *)title {
    _title = title;
    
    [self.diseaseBtn setTitle:title forState:UIControlStateNormal];
    self.diseaseBtn.tag = self.btnTag;
    

}

-(NSMutableArray *)diseaseBtnArray {
    if (_diseaseBtnArray == nil) {
        _diseaseBtnArray = [NSMutableArray array];
    }
    return _diseaseBtnArray;
}




@end

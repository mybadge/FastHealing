//
//  FHDoctorRecView.m
//  FastHealing
//
//  Created by xianbinniu on 16/1/23.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHDoctorRecView.h"
#import "Masonry.h"
#import "SVProgressHUD.h"

@interface FHDoctorRecView ()

@property(nonatomic,weak)UIButton *BaseBtn;
@property(nonatomic,weak)UILabel *first;
@end

@implementation FHDoctorRecView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self addchildView];
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}
-(void)addchildView{
    UIButton *btn=[[UIButton alloc]init];
    btn.frame=CGRectMake(10, 10, 80, 40);
    btn.titleLabel.font=[UIFont systemFontOfSize:18];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitle:@"基本条件" forState:UIControlStateNormal];
    [self addSubview:btn];
}
-(void)setArrM:(NSArray *)ArrM{
    _ArrM=ArrM;
    
    for (int i=0; i<ArrM.count; i++) {
        UILabel *lable=[[UILabel alloc]init];
        if (i==0) {
             lable.frame=CGRectMake(15, 50, FHScreenSize.width,35);
            lable.text=ArrM[i];
            lable.font=[UIFont systemFontOfSize:15];
            lable.textColor=[UIColor lightGrayColor];
            [lable sizeToFit];
            [self addSubview:lable];
            self.first=lable;
            continue;
        }
        lable.frame=CGRectMake(15, CGRectGetMaxY(self.first.frame)+4, FHScreenSize.width, 35);
        self.first=lable;
        lable.text=ArrM[i];
        lable.font=[UIFont systemFontOfSize:15];
        lable.textColor=[UIColor lightGrayColor];
        [lable sizeToFit];
        [self addSubview:lable];
        }
    [SVProgressHUD dismiss];
}
@end

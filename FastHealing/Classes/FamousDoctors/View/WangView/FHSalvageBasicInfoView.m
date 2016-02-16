//
//  FHSalvageBasicInfoView.m
//  FastHealing
//
//  Created by 王 on 16/1/21.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHSalvageBasicInfoView.h"


@interface FHSalvageBasicInfoView ()

@property (strong, nonatomic) UIView *quitView;

@end

@implementation FHSalvageBasicInfoView



-(void)setName:(NSString *)name {
    _name = name;
    
    //标题设值
    self.diseaseTitle.text = [NSString stringWithFormat:@"%@-%@",self.title,self.name];
    self.diseaseTitle.textColor = FHPublicBenefitColor;
    
    //是否贫困按钮设置
    [self.PoorNo setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.PoorNo setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.poorYes setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.poorYes setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];

    self.PoorNo.selected = YES;
    
    //是否残疾按钮设置
    [self.disableNo setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.disableNo setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.disableYes setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.disableYes setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    self.disableNo.selected = YES;
    
    //设置提示label
    self.tipLabel.textColor = FHPublicBenefitColor;
    
    //下一步按钮设置
    [self.nextButton setBackgroundColor:FHPublicBenefitColor];
    [self.nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //所有点击view添加手势
    [self setTapGestureToChoosenView:self.relationshipView];
    [self setTapGestureToChoosenView:self.provinceView];
    [self setTapGestureToChoosenView:self.cityView];
    [self setTapGestureToChoosenView:self.districtView];
    
    //监听键盘弹出通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardFrameHasChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

//监听到键盘通知,增加view用于消除键盘
- (void)keyboardFrameHasChanged:(NSNotification *)notice {
//    NSLog(@"键盘弹出");
//    NSDictionary *userInfo = notice.userInfo;
//    NSLog(@"%@",userInfo);
//    CGRect rect = [[userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
//    
//    UIView *v = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    if (rect.origin.y > 600) {
//
//        self.quitView = v;
//        v.backgroundColor = [UIColor clearColor];
//        [self addSubview:v];
//        UITapGestureRecognizer *tapToQuit = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(quitViewClick)];
//        [v addGestureRecognizer:tapToQuit];
//    }else {
//        [v removeFromSuperview];
//    }
   
}

- (void)quitViewClick {
    [self.patientchildAge endEditing:YES];
}

- (void)setTapGestureToChoosenView:(UIView *)view {
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chosenViewClick:)];
    [view addGestureRecognizer:gesture];
    
}

//左右两侧View的点击事件
- (IBAction)letfAndRightViewClick:(id)sender {
    [self endEditing:YES];
}



//view的手势点击事件
- (void)chosenViewClick:(UITapGestureRecognizer *)gesture {
//    NSLog(@"%ld",gesture.view.tag);
    if ([self.delegate respondsToSelector:@selector(showMoreChoicesWithTapView:)]) {
        [self.delegate showMoreChoicesWithTapView:gesture.view];
    }
    
    [self endEditing:YES];
    
    
}

- (IBAction)poorYesClick {
    self.poorYes.selected = !self.poorYes.selected;
    self.PoorNo.selected = !self.poorYes.selected;
//    NSLog(@"穷困是");
}
- (IBAction)poorNoClick {
    self.poorYes.selected = !self.poorYes.selected;
    self.PoorNo.selected = !self.poorYes.selected;
//    NSLog(@"穷困否");
}

- (IBAction)disbleBtnClick:(id)sender {
    self.disableYes.selected = !self.disableYes.selected;
    self.disableNo.selected = !self.disableNo.selected;
//    NSLog(@"残疾是");
}
- (IBAction)disbleNoClick:(id)sender {
    self.disableYes.selected = !self.disableYes.selected;
    self.disableNo.selected = !self.disableNo.selected;
//    NSLog(@"残疾否");
}
- (IBAction)nextBtnClick {
    //判断各个信息是否输入完整
    
    if (self.patientChildName.text.length == 0) {
        NSLog(@"信息不全");
        if ([self.delegate respondsToSelector:@selector(alertInformationNotComplete:)]) {
            [self.delegate alertInformationNotComplete:@"请输入患儿姓名"];
        }
        return;
    }
    if (self.patientParentName.text.length == 0) {
        NSLog(@"信息不全");
        if ([self.delegate respondsToSelector:@selector(alertInformationNotComplete:)]) {
            [self.delegate alertInformationNotComplete:@"请输入家长姓名"];
        }
        return;
    }
    if (self.patientTelnumber.text.length == 0) {
        NSLog(@"信息不全");
        if ([self.delegate respondsToSelector:@selector(alertInformationNotComplete:)]) {
            [self.delegate alertInformationNotComplete:@"请输入联系电话"];
        }
        return;
    }
    if (self.patientchildAge.text.length == 0) {
        NSLog(@"信息不全");
        if ([self.delegate respondsToSelector:@selector(alertInformationNotComplete:)]) {
            [self.delegate alertInformationNotComplete:@"请输入患儿年龄"];
        }
        return;
    }
    if (self.isChosenCity) {
//        NSLog(@"跳转页面");
        if ([self.delegate respondsToSelector:@selector(turnToNextInterface)]) {
            [self.delegate turnToNextInterface];
        }

        return;
    } else {
        if ([self.delegate respondsToSelector:@selector(alertInformationNotComplete:)]) {
            [self.delegate alertInformationNotComplete:@"请选择地区"];
        }
    }

    

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)loadSalvageBasicViewWithXib {
    return [[NSBundle mainBundle]loadNibNamed:@"FHSalvageBasicInfoView" owner:nil options:nil].lastObject;
}

@end

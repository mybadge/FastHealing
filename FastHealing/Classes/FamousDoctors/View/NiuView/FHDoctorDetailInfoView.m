//
//  FHDoctorDetailInfoView.m
//  FastHealing
//
//  Created by xianbinniu on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHDoctorDetailInfoView.h"
#import "FHDoctorDetailScrollView.h"

@interface FHDoctorDetailInfoView ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *recepL;
@property (weak, nonatomic) IBOutlet UILabel *DoctorL;
@property (weak, nonatomic) IBOutlet UILabel *recepTimeL;
@property (weak, nonatomic) IBOutlet UIView *AnimationView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *AnimationleftConstraint;
@property (weak, nonatomic) IBOutlet FHDoctorDetailScrollView *contentView;
@property (weak, nonatomic) IBOutlet UIView *BackView;

@property(nonatomic,weak)UILabel *currentLable;
@property (weak, nonatomic) IBOutlet UIButton *appimentBtn;

@end

@implementation FHDoctorDetailInfoView

+(instancetype)loadDoctorDetailInfoView{
    
    return [[[NSBundle mainBundle]loadNibNamed:@"FHDoctorDetailInfoView" owner:nil options:nil] firstObject];
   
}
-(void)awakeFromNib{
    self.recepL.textColor = [UIColor cyanColor];
    self.currentLable = self.recepL;
     self.contentView.delegate = self;
    self.BackView.backgroundColor=FHColor(240, 240, 240);
    [self.appimentBtn setBackgroundImage:[UIImage imageNamed:@"login_button_Normal-state"] forState:UIControlStateNormal];
}
-(void)setRecModel:(FHDoctorRecModel *)RecModel{
    _RecModel = RecModel;
    //数组
    self.contentView.ArrM=RecModel.receiving_settings;
    
    
}
-(void)setDoctorModel:(FHDoctorIntro *)DoctorModel{
    _DoctorModel=DoctorModel;
    self.contentView.contentIntorStr = DoctorModel.introduction;
}
-(void)setDoctorRecTimeModel:(FHDoctorRecTimeModel *)DoctorRecTimeModel{
    _DoctorRecTimeModel=DoctorRecTimeModel;
    self.contentView.DoctorRecTimeModel=DoctorRecTimeModel;
}
- (IBAction)LableTap:(UITapGestureRecognizer *)sender {
     UILabel *lable = (UILabel *)sender.view;
    //解决bug,防止重负点击,
    if (self.currentLable == lable) {
        return;
    }
    lable.textColor = [UIColor cyanColor];
    self.AnimationleftConstraint.constant=lable.origin.x;
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
    self.currentLable.textColor = [UIColor blackColor];
    self.currentLable = lable;
    [self.contentView setContentOffset:CGPointMake(lable.tag*FHScreenSize.width,0) animated:YES];
    self.appimentBtn.hidden = lable.tag == 2;
}
- (IBAction)appimentBtnClick:(UIButton *)sender {
    [self.contentView setContentOffset:CGPointMake(2*FHScreenSize.width, 0) animated:YES];
    self.appimentBtn.hidden = YES;
    self.recepTimeL.textColor= [UIColor cyanColor];
    self.currentLable.textColor =[UIColor blackColor];
    self.currentLable=self.recepTimeL;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.AnimationleftConstraint.constant=scrollView.contentOffset.x/FHScreenSize.width*self.recepL.frame.size.width;
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
   NSInteger index= (NSInteger)scrollView.contentOffset.x/FHScreenSize.width;
    self.appimentBtn.hidden = index == 2;

    switch (index) {
        case 0:{
            //解决bug,防止拖拽重复向右
            if (self.currentLable==self.recepL) {
                break;
            }
            
            self.recepL.textColor = [UIColor cyanColor];
            self.currentLable.textColor=[UIColor blackColor];
            self.currentLable = self.recepL;
        }
            break;
        case 1:{
            //解决bug,防止拖拽重复向右
            if (self.currentLable==self.DoctorL) {
                break;
            }
            self.DoctorL.textColor = [UIColor cyanColor];
            self.currentLable.textColor=[UIColor blackColor];
            self.currentLable = self.DoctorL;
        }
            break;
        case 2:{
            //解决bug,防止拖拽重复向右
            if (self.currentLable==self.recepTimeL) {
                break;
            }
            self.recepTimeL.textColor = [UIColor cyanColor];
            self.currentLable.textColor=[UIColor blackColor];
            self.currentLable = self.recepTimeL;
        }
            break;
        default:
            break;
    }
    
}
@end

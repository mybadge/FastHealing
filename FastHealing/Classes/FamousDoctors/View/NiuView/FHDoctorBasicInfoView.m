//
//  FHDoctorBasicInfoView.m
//  FastHealing
//
//  Created by xianbinniu on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHDoctorBasicInfoView.h"
#import "UIImageView+WebCache.h"
#import "FHDoctorInfoModel.h"
@interface FHDoctorBasicInfoView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *professionalL;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (weak, nonatomic) IBOutlet UIButton *appointBtn;
@property (weak, nonatomic) IBOutlet UIButton *flowerBtn;
@property (weak, nonatomic) IBOutlet UIButton *silkBannerBtn;
@end
@implementation FHDoctorBasicInfoView

+(instancetype)loadDoctorBasicInfoView{
    return [[[NSBundle mainBundle]loadNibNamed:@"FHDoctorBasicInfoView" owner:nil options:nil] lastObject];
    
}
-(void)awakeFromNib{
    [self.appointBtn setImage:[UIImage imageNamed:@"adjunction"] forState:UIControlStateNormal];
    self.appointBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    [self.flowerBtn setImage:[UIImage imageNamed:@"discuss"] forState:UIControlStateNormal];
    self.flowerBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    [self.silkBannerBtn setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
    //是否是5S;5S的字体变小
    if ([UIScreen mainScreen].bounds.size.width<375) {
        self.appointBtn.titleLabel.font=[UIFont systemFontOfSize:14];
         self.flowerBtn.titleLabel.font=[UIFont systemFontOfSize:14];
         self.silkBannerBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    }
//    self.silkBannerBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
}
-(void)setDoctoeModel:(FHDoctorInfoModel *)DoctoeModel{
    _DoctoeModel = DoctoeModel;
    self.iconView.layer.cornerRadius = 35;
    self.iconView.layer.masksToBounds = YES;
    self.iconView.contentMode = UIViewContentModeScaleAspectFill;
//    [self.iconView sd_setImageWithURL:[NSURL URLWithString:DoctorInfoModel.doctor_portrait] placeholderImage:[UIImage imageNamed:@"doctor_default"]];
//    self.nameLable.text=DoctorInfoModel.doctor_name;
//    self.ProfessLable.text=DoctorInfoModel.doctor_title_name;
//    self.Hospital.text=DoctorInfoModel.doctor_hospital_name;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:DoctoeModel.doctor_portrait] placeholderImage:[UIImage imageNamed:@"doctor_default"]];
    self.nameL.text = DoctoeModel.doctor_name;
    self.professionalL.text = DoctoeModel.doctor_title_name;
    self.addressL.text =DoctoeModel.doctor_hospital_name;
    [self.appointBtn setTitle:[NSString stringWithFormat:@"预约量:%i",DoctoeModel.operation_count] forState:UIControlStateNormal];
    [self.flowerBtn setTitle:[NSString stringWithFormat:@"鲜花量:%i",DoctoeModel.flower] forState:UIControlStateNormal];
    [self.silkBannerBtn setTitle:[NSString stringWithFormat:@"锦旗量:%i",DoctoeModel.banner] forState:UIControlStateNormal];

}

@end

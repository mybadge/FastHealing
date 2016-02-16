//
//  FHDoctorDetailInfoView.h
//  FastHealing
//
//  Created by xianbinniu on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHDoctorRecModel.h"
#import "FHDoctorIntro.h"
#import "FHDoctorFeeModel.h"
#import "FHDoctorDutyModel.h"
#import "FHDoctorRecTimeModel.h"

@interface FHDoctorDetailInfoView : UIView
+(instancetype)loadDoctorDetailInfoView;
//就诊条件模型
@property(nonatomic,strong) FHDoctorRecModel *RecModel;
//医生简介模型
@property(nonatomic,strong) FHDoctorIntro *DoctorModel;
//医生就诊时间信息模型
@property(nonatomic,strong) FHDoctorRecTimeModel *DoctorRecTimeModel;
@end

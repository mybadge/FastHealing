//
//  FHDoctorDetailScrollView.h
//  FastHealing
//
//  Created by xianbinniu on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHDoctorDutyModel.h"
#import "FHDoctorFeeModel.h"
#import "FHDoctorRecTimeModel.h"
@interface FHDoctorDetailScrollView : UIScrollView
//传递给ReView的参数数组,就诊条件
@property(nonatomic,strong)NSArray *ArrM;
//传递的参数值,医生简介
@property(nonatomic,copy)NSString *contentIntorStr;
//医生值班时间信息模型
@property(nonatomic,strong) FHDoctorRecTimeModel *DoctorRecTimeModel;
@end

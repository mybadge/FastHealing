//
//  FHDoctorBasicInfoView.h
//  FastHealing
//
//  Created by xianbinniu on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FHDoctorInfoModel;

@interface FHDoctorBasicInfoView : UIView

+(instancetype)loadDoctorBasicInfoView;
//医生信息模型
@property(nonatomic,strong)  FHDoctorInfoModel *DoctoeModel;
@end

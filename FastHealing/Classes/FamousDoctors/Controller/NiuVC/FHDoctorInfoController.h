//
//  FHDoctorInfoController.h
//  FastHealing
//
//  Created by xianbinniu on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHDoctorInfoModel.h"
#import "FHDoctorInfoController.h"
@interface FHDoctorInfoController : UIViewController
//参数字典
@property(nonatomic,strong) NSDictionary *paramDict;
@property(nonatomic,strong) FHDoctorInfoModel *model;
@end

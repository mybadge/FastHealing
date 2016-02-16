//
//  FHDoctorFeeModel.h
//  FastHealing
//
//  Created by xianbinniu on 16/1/22.
//  Copyright © 2016年 FastHealing. All rights reserved.
//
/*
 zuozhen_department_name = 神经内科,
	icon_type = 1,
	zuozhen_fee = 12,
	zuozhen_address = 走哪算哪,
	zuozhen_id = 144,
	offer_time = 9：00,
	zuozhen_hospital_name = 北京协和医院
 */
#import <Foundation/Foundation.h>

@interface FHDoctorFeeModel : NSObject
@property(nonatomic,copy)NSString *zuozhen_hospital_name;
@property(nonatomic,copy)NSString *zuozhen_address;
@property(nonatomic,copy)NSString *zuozhen_id;
@property(nonatomic,copy)NSString *icon_type;
@property(nonatomic,copy)NSString *offer_time;
@property(nonatomic,copy)NSString *zuozhen_fee;
@end

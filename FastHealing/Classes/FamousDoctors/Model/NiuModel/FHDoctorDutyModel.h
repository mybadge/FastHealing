//
//  FHDoctorDutyModel.h
//  FastHealing
//
//  Created by xianbinniu on 16/1/22.
//  Copyright © 2016年 FastHealing. All rights reserved.
//
/*
 duty_status_name = 有号,
	icon_type = 1,
	duty_status = 1,
	duty_source_id = 5561,
	zuozhen_id = 144,
	duty_code = 1,
	has_number = 1,
	duty_date = 2015-12-30
 */
#import <Foundation/Foundation.h>

@interface FHDoctorDutyModel : NSObject

@property(nonatomic,copy)NSString *duty_status_name;
@property(nonatomic,copy)NSString *duty_date;
@property(nonatomic,strong) NSNumber *icon_type;
@property(nonatomic,strong) NSNumber *duty_source_id;
@property(nonatomic,strong) NSNumber *duty_code;
@property(nonatomic,strong) NSNumber *has_number;

@end

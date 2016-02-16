//
//  FHDoctorRecModel.h
//  FastHealing
//
//  Created by xianbinniu on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//
/*
 {
	msg = OK,
	data = {
	receiving_setting_extra = 特殊条件特殊条件特殊条件特殊条件特殊条件特殊条件 特殊条件特殊条件特殊条件特殊条件特殊条件特殊条件特殊条件特殊条件特殊条件啊谁都发生地方,
	receiving_settings = [
 需要提供并发症,
 需要患者为首诊,
 需要提供个人史,
 需要提供疾病描述,
 需要提供病例
 ]
 },
	code = 0
 }
 */
#import <Foundation/Foundation.h>

@interface FHDoctorRecModel : NSObject
//特殊条件
@property(nonatomic,copy)NSString *receiving_setting_extra;
//条件
@property(nonatomic,copy)NSArray *receiving_settings;

@end

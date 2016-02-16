//
//  FHDoctorInfoModel.h
//  FastHealing
//
//  Created by xianbinniu on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//
/*
    easymob_id = d300000315,
	mentor_id = 0,
	doctor_id = 300000315,
	doctor_gender = 1,
	flower_fee = 0,
	hospital_name = 北京协和医院,
	doctor_portrait = http://hdkj-web1.chinacloudapp.cn:8080/res/2093000003151445677716555.jpg,
	flower = 0,
	mentor_content = <null>,
	banner_fee = 0,
	flower_fee_name = <null>,
	doctor_title_name = 心理医生,
	banner = 0,
	is_saved = 2,
	banner_fee_name = <null>,
	doctor_name = 何晔鑫,
	operation_count = 0,
	department_name = 变态反应科门诊
    accuracy = 88%
 */
#import <Foundation/Foundation.h>

@interface FHDoctorInfoModel : NSObject
//医生ID
@property(nonatomic,strong)NSNumber *doctor_id;
//鲜花量
@property(nonatomic,assign) int flower;
//锦旗量
@property(nonatomic,assign) int banner;
//预约量
@property(nonatomic,assign)int operation_count;
//医院名称(详情页)
@property(nonatomic,copy)NSString *hospital_name;
//医院名称(匹配医生页)
@property(nonatomic,copy)NSString *doctor_hospital_name ;
//医生职称
@property(nonatomic,copy)NSString *doctor_title_name;
//头像
@property(nonatomic,copy)NSString *doctor_portrait;
//医生名字
@property(nonatomic,copy)NSString *doctor_name;
//科室
@property(nonatomic,copy)NSString *department_name;
//匹配度
@property(nonatomic,copy)NSString *accuracy;

@end

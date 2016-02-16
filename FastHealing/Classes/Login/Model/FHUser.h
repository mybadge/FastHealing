//
//  FHUser.h
//  FastHealing
//
//  Created by 赵志丹 on 16/1/19.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FHUser : NSObject

/**
 msg = OK,
	data = {
	gender = 1,
	mobile_number = 13269130063,
	province_id = 370000,
	county_id = 0,
	age = 28,
	user_id = 1000089,
	true_name = 王云财,
	weight = 156.0,
	city_id = 0,
	is_certify = 1,
	address = 山东省,
	card_type = 1,
	easymob_password = 123456,
	associate_id = <null>,
	login_token = 321017f8952c7a60fd626c470dd452b9,
	easymob_id = u1000089,
	head_photo = http://hdkj-web1.chinacloudapp.cn:8080/res/1071000089-1451374760656.png,
	card_number = 110109198707061355,
	height = 185.0
 */


@property (nonatomic, copy) NSString *true_name;
/** 身份证号 */
@property (nonatomic, copy) NSString *card_number;
@property (nonatomic, copy) NSString *mobile_number;
@property (nonatomic, copy) NSString *height;
@property (nonatomic, copy) NSString *weight;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *easymob_password;
@property (nonatomic, copy) NSString *head_photo;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *gender;

+ (instancetype)userWithDict:(NSDictionary *)dict;

@end

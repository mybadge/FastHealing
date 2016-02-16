//
//  FHMyCollectionModel.h
//  FastHealing
//
//  Created by tao on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *   int doctor_attention_id; //医生关注id
 int doctor_id; //医生id
 int hospital_id; // 医院id
 String hospital_name; //医院名称
 int flower; //鲜花
 int banner; //锦旗
 int operation_count; //手术数量
 int doctor_title_id;// 医生职称
 String portrait;// 医生头像
 String doctor_title_name; //医生职称名称
 String easymob_id; // 环信id
 */
@interface FHMyCollectionModel : NSObject
/**
 *
	doctor_gender = 1,
	doctor_id = 300000358,
	hospital_name = 北京协和医院,
	doctor_portrait = http:iosapi.itcast.cn/image/2093000003581449631802827.png,
	flower = 0,
	doctor_title_id = 0,
	doctor_title_name = 教授,
	banner = 0,
	doctor_name = suqiudong,
	easymob_id = d300000358,
	doctor_attention_id = 174,
	hospital_id = 1,
	operation_count = 0
 */



/**
*  医生名字
*/
@property (copy, nonatomic) NSString *doctor_name;
/**
 *  医生职务
 */
@property (copy, nonatomic) NSString *doctor_title_name;

/**
 *  手术数量
 */
@property (copy, nonatomic) NSString *operation_count;
/**
 *  鲜花数
 */
@property (copy, nonatomic) NSString *flower;

/**
 *  锦旗数
 */
@property (copy, nonatomic) NSString *banner;

/**
 *  医生头像
 */
@property (copy, nonatomic) NSString *doctor_portrait;

/**
 *  医院名字
 */
@property (copy, nonatomic) NSString *hospital_name;

/**
 *  医生的id
 */

@property (copy, nonatomic) NSString *doctor_id;;
@end

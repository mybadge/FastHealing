//
//  FHFamousModel.h
//  FastHealing
//
//  Created by tao on 16/1/21.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FHFamousModel : NSObject

/**
 *  orders      名医通列表
 order_id;//订单Id
 true_name;//患者姓名
 duty_date;//就诊日期
 ci3_name;//三级疾病名称
 doctor_name;//医生名称
 doctor_title_name;//医生职称名称
 hospital_name;//医院名称
 order_status;//订单状态
 order_status_name;//订单状态显示名称
 is_changed;//是否有气泡
 */


/**
*  患者姓名
*/

@property (copy, nonatomic) NSString *true_name;
/**
 *  就诊日期
 */
@property (copy, nonatomic) NSString *duty_date;

/**
 *  三级疾病名称
 */

@property (copy, nonatomic) NSString *ci3_name;

/**
 *  医生名字
 */
@property (copy, nonatomic) NSString *doctor_name;
/**
 *  医生职称
 */
@property (copy, nonatomic) NSString *doctor_title_name;

/**
 *  医院名称
 */
@property (copy, nonatomic) NSString *hospital_name;

//订单状态
@property (copy, nonatomic) NSString *order_status;

/**
 *  是否有气泡
 */

//@property (assign, nonatomic)  BOOL is_changed;
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)famousModelWithDict:(NSDictionary *)dict;
@end

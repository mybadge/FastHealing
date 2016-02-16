//
//  FHDoctorMessageModel.h
//  FastHealing
//
//  Created by tao on 16/1/22.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FHDoctLabesModel.h"


@interface FHDoctorMessageModel : NSObject

/**
 *  introduction   简介
 doctor_lables  医生标签列表
 lable_status_name 状态名称
 lable_status    状态
 doctor_mentor_id 导师Id
 lable_type 标签类型
 lable_content 标签内容
 */
@property (copy, nonatomic) NSString *introduction;

@property (strong, nonatomic) FHDoctLabesModel *doctor_lables;
/**
 *  判断是不是描述界面
 */

@property (assign, nonatomic)  BOOL isIntroduction;

@end

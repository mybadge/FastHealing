//
//  FHNetworkTools.h
//  FastHealing
//
//  Created by ZhangZiang on 16/1/21.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
//模型

#import "FHDoctorIntro.h"
#import "FHDoctorRecModel.h"
#import "FHDoctorInfoModel.h"
#import "FHDoctorFeeModel.h"
#import "FHDoctorDutyModel.h"
#import "FHDoctorRecTimeModel.h"
#import "FHWeather_data.h"
#import "FHPagerModel.h"
#import "Reachability.h"

@interface FHNetworkTools : AFHTTPSessionManager
+ (instancetype)sharedNetworkTools;
//获取医生的信息
- (void)getDoctorInfoWithDict:(NSDictionary *)dict andSuccess:(void(^)(FHDoctorInfoModel *DocInfoModel))success andFailure:(void(^)(NSError * error))Failure;
//就诊条件信息
-(void)getDoctorReceivingSettingWithDict:(NSDictionary *)dict andSuccess:(void(^)(FHDoctorRecModel *DocInfoModel))success andFailure:(void(^)(NSError * error))Failure;
//医生详细信息
- (void)getDoctorIntroductionWithDict:(NSDictionary *)dict andSuccess:(void(^)(FHDoctorIntro *DocInfoModel))success andFailure:(void(^)(NSError * error))Failure;
//匹配到的医生列表
- (void)matchDoctorsIntroductionWithDict:(NSDictionary *)dict andSuccess:(void(^)(NSArray *dalalist))success andFailure:(void(^)(NSError * error))Failure;
//医生值班时间
- (void)matchDoctorDutiesWithDict:(NSDictionary *)dict andSuccess:(void(^)(FHDoctorRecTimeModel *model))success andFailure:(void(^)(NSError * error))Failures;
//添加关注的医生
-(void)addDoctorWithDict:(NSDictionary *)dict andSuccess:(void(^)(bool success))success andFailure:(void(^)(NSError * error))Failures;
//取消关注的医生
-(void)deleteDoctorWithDict:(NSDictionary *)dict andSuccess:(void(^)(bool success))success andFailure:(void(^)(NSError * error))Failures;
//获取关注的医生列表
-(void)getDoctorListWithDict:(NSDictionary *)dict andSuccess:(void(^)(NSArray *datalist))success andFailure:(void(^)(NSError * error))Failure;
//天气请求
- (void)upWeatherWithString:(NSString *)city andSuccess:(void(^)(NSArray *dalalist))success andFailure:(void(^)(NSError * error))Failure;
//轮播器
-(void)getBannerWithDict:(NSDictionary *)dict andSuccess:(void(^)(NSArray *datalist))success andFailure:(void(^)(NSError * error))Failure;


/** 是否启用WiFi */
+ (BOOL)isEnableWIFI;
/** 是否启用蜂窝网 */
+ (BOOL)isEnable4G;

@end

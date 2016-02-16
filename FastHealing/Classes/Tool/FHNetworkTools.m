//
//  FHNetworkTools.m
//  FastHealing
//
//  Created by ZhangZiang on 16/1/21.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHNetworkTools.h"
#import "MJExtension.h"
//模型

#define kBDWeather_KEY @"17IvzuqmKrK1cGwNL6VQebF9"

#define kGetWeather_URL(city) ([NSString stringWithFormat: @"http://api.map.baidu.com/telematics/v3/weather?location=%@&output=json&ak=%@", city, kBDWeather_KEY])

@implementation FHNetworkTools

+ (instancetype)sharedNetworkTools {
    
    static FHNetworkTools *_sessionManager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sessionManager = [self manager];
        
        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];

        NSSet *set = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
       
        
        _sessionManager.responseSerializer.acceptableContentTypes =[_sessionManager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:set];
    });
    
    return _sessionManager;

}
//获取医生的信息
- (void)getDoctorInfoWithDict:(NSDictionary *)dict andSuccess:(void(^)(FHDoctorInfoModel *DocInfoModel))success andFailure:(void(^)(NSError * error))Failure
{
    
    NSString *url = @"http://iosapi.itcast.cn/getDoctorInfo.json.php";
//    NSDictionary *paramDic = @{@"login_token":FHLoginToken,@"user_id":@(1000089),@"doctor_id":dict[@"doctor_id"]};
    
    [self POST:url parameters:dict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        //获取对应的数据,并转模型
//        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        FHDoctorInfoModel *model = [FHDoctorInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
        //回调
        if (model!=nil) {
            success(model);
        }else{
            //            数据为空
            NSLog(@"数据为空");
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        Failure(error);
    }];
 
}
    //就诊条件信息
-(void)getDoctorReceivingSettingWithDict:(NSDictionary *)dict andSuccess:(void(^)(FHDoctorRecModel *DocInfoModel))success andFailure:(void(^)(NSError * error))Failure {
        NSString *url = @"http://iosapi.itcast.cn/doctorReceivingSetting.json.php";
        //参数
        NSDictionary *paramDic = @{@"login_token":FHLoginToken,@"doctor_id":dict[@"doctor_id"]};
    
    [self POST:url parameters:paramDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        //获取对应的数据,并转模型
//        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        
        FHDoctorRecModel *model = [FHDoctorRecModel mj_objectWithKeyValues:responseObject[@"data"]];
        //回调
        if (model!=nil) {
            success(model);
        }else{
            //            数据为空
            NSLog(@"数据为空");
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        Failure(error);
    }];
    }
//医生详细信息
- (void)getDoctorIntroductionWithDict:(NSDictionary *)dict andSuccess:(void(^)(FHDoctorIntro *DocInfoModel))success andFailure:(void(^)(NSError * error))Failure {
    NSString *url = @"http://iosapi.itcast.cn/getIntroduction.json.php";
//    NSDictionary *paramDic = @{@"login_token":FHLoginToken,@"doctor_id":dict[@"doctor_id"]};
    [self POST:url parameters:dict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        //        字典转模型
//        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        FHDoctorIntro *model = [FHDoctorIntro mj_objectWithKeyValues:responseObject[@"data"]];
        //回调
        if (model!=nil) {
            success(model);
        }else{
            //            数据为空
            NSLog(@"数据为空");
        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        Failure(error);
    }];
  
}
//匹配到的医生列表
- (void)matchDoctorsIntroductionWithDict:(NSDictionary *)dict andSuccess:(void(^)(NSArray *dalalist))success andFailure:(void(^)(NSError * error))Failure{
    NSString *url = @"http://iosapi.itcast.cn/matchDoctors.json.php";
//    NSDictionary *paramDic = @{@"login_token":FHLoginToken,@"ci1_id":@(1),@"ci2_id":@(3),@"ci3_id":@(3),@"diagnosis_type":@(0),@"is_confirmed":@(1),@"user_id":@(1000089),@"complications":@[@"1",@"",@"",@"",@"",@""],@"has_diagnosis":@(2),@"page":@(3)};
    [self POST:url parameters:dict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        NSLog(@"%@",responseObject);
        //        字典转模型
        NSArray *array=responseObject[@"data"];
        //排空
        if (responseObject[@"data"] != [NSNull null]) {
            NSMutableArray *ArrM=[NSMutableArray array];
            for (NSDictionary *dcit in array) {
                FHDoctorInfoModel *model = [FHDoctorInfoModel mj_objectWithKeyValues:dcit];
                [ArrM addObject:model];
            }
            //回调
            success(ArrM.copy);
        }else{
            success(nil);
        }
   
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        Failure(error);
    }];
}
//医生值班时间
- (void)matchDoctorDutiesWithDict:(NSDictionary *)dict andSuccess:(void(^)(FHDoctorRecTimeModel *model))success andFailure:(void(^)(NSError * error))Failures {
    //
    NSString *url = @"http://iosapi.itcast.cn/doctorDuties.json.php";
//    NSDictionary *paramDic = @{@"login_token":FHLoginToken,@"doctor_id":@(300000336)};
    [self POST:url parameters:dict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        NSLog(@"%@",responseObject);
        //字典转模型,模型嵌套;
        FHDoctorRecTimeModel *model = [FHDoctorRecTimeModel mj_objectWithKeyValues:responseObject[@"data"]];
        success(model);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
    }];
}
//添加关注的医生
-(void)addDoctorWithDict:(NSDictionary *)dict andSuccess:(void(^)(bool success))success andFailure:(void(^)(NSError * error))Failures{
    NSString *url = @"http://iosapi.itcast.cn/addDoctor.json.php";
//    NSDictionary *paramDic = @{@"login_token":FHLoginToken,@"user_id":@(1000089),@"doctor_id":@(300000315)};
    
    [self POST:url parameters:dict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        NSLog(@"%@",responseObject);
        success(YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
//取消关注的医生
-(void)deleteDoctorWithDict:(NSDictionary *)dict andSuccess:(void(^)(bool success))success andFailure:(void(^)(NSError * error))Failures{

    NSString *url = @"http://iosapi.itcast.cn/deleteDoctor.json.php";
    NSDictionary *paramDic = @{@"login_token":FHLoginToken,@"user_id":@(1000089),@"doctor_id":@(300000315)};
    [self POST:url parameters:paramDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        NSLog(@"%@",responseObject);
        //回调;
        success(YES);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
//获取关注的医生列表
-(void)getDoctorListWithDict:(NSDictionary *)dict andSuccess:(void(^)(NSArray *datalist))success andFailure:(void(^)(NSError * error))Failure{
    NSString *url = @"http://iosapi.itcast.cn/doctorList.json.php";
//    NSDictionary *paramDic = @{@"login_token":FHLoginToken,@"user_id":@(1000089),@"page_size":@(15),@"page":@(1)};
    [self POST:url parameters:dict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        //获取数据
//        NSLog(@"%@",responseObject);
        NSArray *DataArr=responseObject[@"data"];
        NSMutableArray *arrM=[NSMutableArray array];
        for (NSDictionary *dict1 in DataArr) {
           NSNumber *str=dict1[@"doctor_id"];
           [arrM addObject:str];
        }
        //回调关注医生ID数组
        success(arrM.copy);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

}

//请求天气数据
- (void)upWeatherWithString:(NSString *)city andSuccess:(void(^)(NSArray *dalalist))success andFailure:(void(^)(NSError * error))Failure{
   
    NSString *url = kGetWeather_URL(city);
   
    NSString * encodingString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self GET:encodingString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSDictionary *dict = responseObject[@"results"][0][@"weather_data"][0];
        if (dict != nil) {
            
            FHWeather_data *weather = [FHWeather_data mj_objectWithKeyValues:dict];
            NSMutableArray *ArrM=[NSMutableArray array];
            [ArrM addObject:weather];
            success(ArrM);
            
        }
        success(nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
         Failure(error);
        
    }];
    
    
}

//轮播器数据
-(void)getBannerWithDict:(NSDictionary *)dict andSuccess:(void(^)(NSArray *datalist))success andFailure:(void(^)(NSError * error))Failure{
    
    NSString *url = @"http://iosapi.itcast.cn/banners.json.php";
    NSDictionary *paramDic = @{@"login_token":FHLoginToken,@"page_size":@(10),@"page":@(1)};
    
    [self POST:url parameters:paramDic success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *response) {
        NSArray *banners = response[@"data"][@"banners"];
        
        NSMutableArray *bannerM = [NSMutableArray arrayWithCapacity: banners.count];
        
        for (int i = 0; i < banners.count; ++ i) {
            
            FHPagerModel *banner = [[FHPagerModel alloc] init];
            
            [banner mj_setKeyValues:banners[i]];
            
            [bannerM addObject: banner];
        }
        
       success(bannerM.copy);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}


+ (BOOL)isEnableWIFI{
    return [[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable;
}

+ (BOOL)isEnable4G{
    return [[Reachability reachabilityForInternetConnection] currentReachabilityStatus] !=NotReachable;
}

@end

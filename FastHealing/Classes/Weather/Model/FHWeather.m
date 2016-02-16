//
//  FHWeather.m
//  FastHealing
//
//  Created by 赵志丹 on 16/1/22.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHWeather.h"
#import "MJExtension.h"
#import "FHWeather_data.h"

@implementation FHWeather
+ (NSDictionary *)mj_objectClassInArray {
    return @{ @"weather_data": [FHWeather_data class]};
}
@end

//
//  FHWeather_data.h
//  FastHealing
//
//  Created by 赵志丹 on 16/1/22.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FHWeather_data : NSObject
@property (nonatomic, copy) NSString *nightPictureUrl;
@property (nonatomic, copy) NSString *weather;
@property (nonatomic, copy) NSString *wind;
@property (nonatomic, copy) NSString *temperature;
@property (nonatomic, copy) NSString *dayPictureUrl;
@property (nonatomic, copy) NSString *date;
@end

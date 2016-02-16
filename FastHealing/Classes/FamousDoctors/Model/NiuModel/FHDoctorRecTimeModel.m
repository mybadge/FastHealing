//
//  FHDoctorRecTimeModel.m
//  FastHealing
//
//  Created by xianbinniu on 16/1/22.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHDoctorRecTimeModel.h"
#import "FHDoctorDutyModel.h"
#import "FHDoctorFeeModel.h"
@implementation FHDoctorRecTimeModel

+(NSDictionary *)mj_objectClassInArray{
    
    return @{@"zuozhen_infos":[FHDoctorFeeModel class],@"duties":[FHDoctorDutyModel class]};
}


@end

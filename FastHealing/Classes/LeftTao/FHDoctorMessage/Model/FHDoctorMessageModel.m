//
//  FHDoctorMessageModel.m
//  FastHealing
//
//  Created by tao on 16/1/22.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHDoctorMessageModel.h"
#import "MJExtension.h"
#import "FHDoctLabesModel.h"

@implementation FHDoctorMessageModel

//- (NSArray *)propertyKeysForClass:(Class)c;
//[self.doctor_lables

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"doctor_lables" : [FHDoctLabesModel class]};
}

@end

//
//  FHDoctorRecTimeModel.h
//  FastHealing
//
//  Created by xianbinniu on 16/1/22.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface FHDoctorRecTimeModel : NSObject<MJKeyValue>

@property(nonatomic,strong) NSArray *zuozhen_infos;

@property(nonatomic,strong) NSArray *duties;

@property(nonatomic,copy)NSString *start_date;
//
//@property(nonatomic,assign)NSInteger *period;

@end

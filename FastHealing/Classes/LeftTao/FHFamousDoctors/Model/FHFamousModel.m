//
//  FHFamousModel.m
//  FastHealing
//
//  Created by tao on 16/1/21.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHFamousModel.h"

@implementation FHFamousModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)famousModelWithDict:(NSDictionary *)dict{
    
   return  [[self alloc]initWithDict:dict];
    
  
}

@end

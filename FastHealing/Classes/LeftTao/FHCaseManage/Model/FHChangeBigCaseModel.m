//
//  FHChangeBigCaseModel.m
//  FastHealing
//
//  Created by tao on 16/1/26.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHChangeBigCaseModel.h"

@implementation FHChangeBigCaseModel



- (instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


+ (instancetype)changeBigCaseModelWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}




@end

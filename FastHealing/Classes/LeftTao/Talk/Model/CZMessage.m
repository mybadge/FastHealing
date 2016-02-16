//
//  CZMessage.m
//  qq01数据加载
//
//  Created by tao on 15/10/10.
//  Copyright (c) 2015年 tao. All rights reserved.
//

#import "CZMessage.h"

@implementation CZMessage


- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)messageWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

@end

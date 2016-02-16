//
//  FHSickSimultaneous.m
//  dcDemo
//
//  Created by ZhangZiang on 16/1/20.
//  Copyright © 2016年 ZhangZiang. All rights reserved.
//

#import "FHSickSimultaneous.h"

@implementation FHSickSimultaneous

+ (NSArray *)sickSimultaneousWithResponseDict:(NSDictionary *)dict {
    NSArray *responseArr = dict[@"data"];
    
    NSMutableArray *arrMu = [NSMutableArray array];
    
    for (NSDictionary *responseDict in responseArr) {
        FHSickSimultaneous *model = [[FHSickSimultaneous alloc]init];
        
        [model setValuesForKeysWithDictionary:responseDict];
        
        [arrMu addObject:model];
    }
    
    return arrMu.copy;
}

@end

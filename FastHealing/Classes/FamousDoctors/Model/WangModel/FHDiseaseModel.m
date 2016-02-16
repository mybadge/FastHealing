//
//  FHDiseaseModel.m
//  FastHealing
//
//  Created by 王 on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHDiseaseModel.h"

@implementation FHDiseaseModel

+(instancetype)diseaseWithDict:(NSDictionary *)dict {

    return [[FHDiseaseModel alloc]initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValue:dict[@"title"] forKey:@"title"];
        [self setValue:dict[@"image"] forKey:@"image"];
//        self.diseaseList = [FHDiseaseListModel diseaseListWithDict:dict[@"disease"]];
        [self setValue:dict[@"disease"] forKey:@"diseaseList"];
    }
    return self;
}

@end

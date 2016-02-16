//
//  FHDiseaseModel.h
//  FastHealing
//
//  Created by 王 on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FHDiseaseModel : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *image;
@property (strong, nonatomic) NSArray *diseaseList;

+ (instancetype)diseaseWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end

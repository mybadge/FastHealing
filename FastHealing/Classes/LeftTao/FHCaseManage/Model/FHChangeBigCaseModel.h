//
//  FHChangeBigCaseModel.h
//  FastHealing
//
//  Created by tao on 16/1/26.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FHChangeBigCaseModel : NSObject

@property (copy, nonatomic) NSString *caseName;

@property (assign, nonatomic)  NSInteger ci1_id;


//字典转模型
- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)changeBigCaseModelWithDict:(NSDictionary *)dict;


@end

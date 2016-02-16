//
//  FHSetingModel.h
//  FastHealing
//
//  Created by xiechen on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FHSetingModel : NSObject

@property (nonatomic,copy)NSString *textName;

@property (nonatomic,copy)NSString *imageName;

@property (nonatomic,copy)NSString *accessImageName;



+ (NSArray *)settingAndHelp;
@end

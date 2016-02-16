//
//  FHSttingFeedBackModel.m
//  FastHealing
//
//  Created by xiechen on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHSttingFeedBackModel.h"
#import "MJExtension.h"

@implementation FHSttingFeedBackModel

+ (NSArray *)sttingFeedBack{
    return [FHSttingFeedBackModel mj_objectArrayWithFilename:@"SettingFeedBack.plist"];
}
@end

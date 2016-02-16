//
//  FHLeftMenu.m
//  FastHealing
//
//  Created by 赵志丹 on 16/1/19.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHLeftMenu.h"
#import "MJExtension.h"

@implementation FHLeftMenu
+ (NSArray *)leftMenus {
    return  [FHLeftMenu mj_objectArrayWithFilename:@"LeftMenu.plist"];
}
@end

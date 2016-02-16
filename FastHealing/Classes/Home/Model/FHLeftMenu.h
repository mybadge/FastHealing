//
//  FHLeftMenu.h
//  FastHealing
//
//  Created by 赵志丹 on 16/1/19.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FHLeftMenu : NSObject
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 要调用的方法 */
@property (nonatomic, copy) NSString *action;
/** 控制器的类名 */
@property (nonatomic, copy) NSString *vcClassName;

+ (NSArray *)leftMenus;
@end

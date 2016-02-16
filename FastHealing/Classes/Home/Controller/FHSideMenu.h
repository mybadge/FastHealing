//
//  FHSideMenu.h
//  FastHealing
//
//  Created by 赵志丹 on 16/1/21.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "RESideMenu.h"

@interface FHSideMenu : RESideMenu

/** 隐藏侧边栏,并回到主界面 */
- (void)hideSideMenu;

/** 设置 内容控制器显示根据传近来的VC */
- (void)showContentControllerWithVC:(UIViewController *)selectedVc;
@end

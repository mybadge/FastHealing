//
//  UIView+ViewController.h
//  FastHealing
//
//  Created by 赵志丹 on 16/1/22.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FHNavigationController, FHSideMenu;
@interface UIView (ViewController)
- (FHNavigationController *)getNavController;

/** 根据FHSideMenu */
- (FHSideMenu *)getSideMenuVc;

/** 根据类类型,获取响应者类对象 */
- (id)getResponserClass:(Class)clz;
@end

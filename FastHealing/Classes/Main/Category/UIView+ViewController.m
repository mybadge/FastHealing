//
//  UIView+ViewController.m
//  FastHealing
//
//  Created by 赵志丹 on 16/1/22.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "UIView+ViewController.h"
#import "FHNavigationController.h"
#import "FHSideMenu.h"

@implementation UIView (ViewController)

- (FHNavigationController *)getNavController {
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[FHNavigationController class]]) {
            return (FHNavigationController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

- (FHSideMenu *)getSideMenuVc {
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[FHSideMenu class]]) {
            return (FHSideMenu *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

/** 根据类类型,获取响应者类对象 */
- (id)getResponserClass:(Class)clz {
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:clz]) {
            return next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

@end

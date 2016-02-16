//
//  FHNavigationController.m
//  FastHealing
//
//  Created by 赵志丹 on 16/1/19.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHNavigationController.h"
#import "FHMainViewController.h"
#import "FHLeftMenu.h"

@interface FHNavigationController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSMutableArray *leftMenuVCList;
@end

@implementation FHNavigationController

//+ (void)initialize{
//    //设置整个项目所有Item的主题样式
//    UIBarButtonItem *item = [UIBarButtonItem appearance];
//    //设置普通状态
//    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
//    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
//    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
////    //设置不可用状态
////    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
////    //disableTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.7];
////    disableTextAttrs[NSFontAttributeName] = textAttrs[NSFontAttributeName];
////    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
////    //[item setTintColor:[UIColor purpleColor]];
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //设置导航条的背景图片
    //[self.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationBar.barTintColor = FHThemeColor;
    //不管用,需要背景图片
    //[self.navigationBar setBackgroundColor:FHColor(58, 194, 197)];
    // 设置文字的颜色为白色
    [self.navigationBar setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    
    // 设置默认渲染的颜色白色
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    //添加手势的代理，一旦自定义了返回按钮，系统的手势倒流就会取消，需要手动添加。
    self.interactivePopGestureRecognizer.delegate = self;
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    //当控制器是主控制器的时候,就不需要给导航控制器包装leftItem.
    if ([viewController isKindOfClass:[FHMainViewController class]]) {
        return [super pushViewController:viewController animated:animated];
    }
    
    
    //这时push进来的Controller 不是第一个控制器,也就是说不是跟控制器
//    if (self.viewControllers.count > 0) {
//        //自动显示和隐藏tabbar
//        viewController.hidesBottomBarWhenPushed = YES;
//        if (viewController.navigationItem.rightBarButtonItem == nil) {
//            viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"回到最上层" style:UIBarButtonItemStylePlain target:self action:@selector(more)];
//        }
//    }
    
    if (self.viewControllers.count >= 2) {
        //自动显示和隐藏tabbar
        //viewController.hidesBottomBarWhenPushed = YES;
        if (viewController.navigationItem.rightBarButtonItem == nil) {
            viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"回到最上层" style:UIBarButtonItemStylePlain target:self action:@selector(more)];
        }
    }

    
    //设置导航栏上的内容
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftButton setImage:[UIImage imageNamed: @"nav_return"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    viewController.navigationItem.leftBarButtonItem = leftItem;
    
    //viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image: @"nav_return" highImage:@"nav_return"];
    
    
    [super pushViewController:viewController animated:animated];
}

////状态栏设为白色
//- (UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleLightContent;
//}

- (void)back{
    [self popViewControllerAnimated:YES];
}

- (void)more{
    [self popToRootViewControllerAnimated:YES];
}

- (BOOL)isKindOfLeftMenuClass:(UIViewController *)vc {
    __block BOOL result = NO;
    [self.leftMenuVCList enumerateObjectsUsingBlock:^(NSString *className, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([vc isKindOfClass:NSClassFromString(className)]) {
            result = YES;
            *stop = YES;
        }
    }];
    return result;
}

/** 目前没有用到 */
- (NSMutableArray *)leftMenuVCList{
    if (!_leftMenuVCList) {
        _leftMenuVCList = [NSMutableArray array];
        NSArray *array = [[FHLeftMenu leftMenus] valueForKeyPath:@"vcClassName"];
        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[NSArray class]]) {
                [obj enumerateObjectsUsingBlock:^(NSString  *str, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (str && ![@"" isEqualToString:str]) {
                        [_leftMenuVCList addObject:str];
                    }
                }];
            }
        }];
    }
    return _leftMenuVCList;
}
@end

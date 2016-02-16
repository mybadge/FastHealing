//
//  FHSideMenu.m
//  FastHealing
//
//  Created by 赵志丹 on 16/1/21.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHSideMenu.h"
#import "FHNavigationController.h"
#import "FHMainViewController.h"
#import "FHLeftTableViewController.h"
#import "FHLoginViewController.h"
#import "FHRegisterViewController.h"


//蒙板最终显示效果
#define ALPHA_SCALE 0.7
//手势X移动预估值
#define SCROLL_X_VALUE [UIScreen mainScreen].bounds.size.width * 0.5

@interface FHSideMenu ()<RESideMenuDelegate>
@property (strong, nonatomic) FHNavigationController *nav;

//添加蒙版View
@property (nonatomic, weak) UIView *blackTopView;
//first touch Point
@property (nonatomic, assign) CGPoint point;
//current alpha
@property (nonatomic, assign) CGFloat currentAlpha;

@property (nonatomic, strong) FHMainViewController *mainVC;

@end

@implementation FHSideMenu

//让主控制器只加载一次
- (FHMainViewController *)mainVC{
    if (!_mainVC) {
        _mainVC = [[FHMainViewController alloc] init];
        typeof(self) weakSelf = self;
        _mainVC.backMainVcBlock = ^(){
            [weakSelf hideMenuViewController];
        };
        
    }
    return _mainVC;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    //接受dismiss的通知
    [FHNotificationCenter addObserver:self selector:@selector(showSideMenu:) name:@"dismissVC" object:nil];
    
    
    //接受关闭左侧菜单的通知
    [FHNotificationCenter addObserver:self selector:@selector(hideSideMenu) name:@"hideSideMenu" object:nil];
}

- (void)dealloc {
    [FHNotificationCenter removeObserver:self];
    NSLog(@"FHSIDe 销毁了-----");
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        FHNavigationController *nav = [[FHNavigationController alloc] initWithRootViewController:self.mainVC];
        FHLeftTableViewController *leftVC = [[FHLeftTableViewController alloc] init];
        //leftVC.view.width = 200;//
        
        leftVC.didSelectedVcBlock = ^(UIViewController *selectedVc) {
            [self showContentControllerWithVC:selectedVc];
        };
        //设置main
        self.contentViewController = nav;
        //设置左边
        self.leftMenuViewController = leftVC;
        
        self.bouncesHorizontally = YES;
        self.scaleContentView = false;
        self.panFromEdge = NO;
        self.fadeMenuView = YES;
        
        //设置阴影效果
        self.contentViewShadowColor = [UIColor blackColor];
        self.contentViewShadowOffset = CGSizeMake(0, 0);
        self.contentViewShadowOpacity = 0.6;
        self.contentViewShadowRadius = 12;
        self.contentViewShadowEnabled = YES;
        
        self.scaleMenuView = YES;
        //调整显示比例
        self.contentViewInPortraitOffsetCenterX = FHSideMenuOffset;
        
        
    }
    return self;
}


//显示侧边栏
- (void)showSideMenu:(NSNotification *)noti{
    [self presentLeftMenuViewController];
    FHNavigationController *nav = [[FHNavigationController alloc]initWithRootViewController:self.mainVC];
    self.nav = nav;
    [self setContentViewController:nav animated:YES];
    
}
//隐藏侧边栏,并回到主界面
- (void)hideSideMenu {
    FHNavigationController *nav = [[FHNavigationController alloc]initWithRootViewController:self.mainVC];
    self.nav = nav;
    [self hideMenuViewController];
    [self setContentViewController:nav animated:YES];
}

// 设置 内容控制器显示 传近来的VC
- (void)showContentControllerWithVC:(UIViewController *)selectedVc {
    //如果是登录控制器 或者是注册控制器,那么就不用包装Nav了
    if ([selectedVc isKindOfClass:[UINavigationController class]] || [selectedVc isKindOfClass:[FHNavigationController class]]) {
        [self hideMenuViewController];
        [self setContentViewController:selectedVc animated:YES];
        return;
    }
    FHNavigationController *nav = [[FHNavigationController alloc]initWithRootViewController:selectedVc];
    self.nav = nav;
    [self hideMenuViewController];
    [self setContentViewController:nav animated:YES];
}



#pragma mark RESideMenuDelegate 代理方法实现

- (void)sideMenu:(RESideMenu *)sideMenu didRecognizePanGesture:(UIPanGestureRecognizer *)recognizer{
}

- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController{
    //FHLog(@"%s",__FUNCTION__);
}
- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController{
    
    self.mainVC.isOpenLeft = YES;
    
    
}
//- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController{
//    FHLog(@"%s",__FUNCTION__);
//    
//}
- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController{
    self.mainVC.isOpenLeft = NO;
}





@end

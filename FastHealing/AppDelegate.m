//
//  AppDelegate.m
//  FastHealing
//
//  Created by 赵志丹 on 16/1/19.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "AppDelegate.h"
#import <SMS_SDK/SMSSDK.h>
#import "FHSideMenu.h"
#import "UIWindow+Extension.h"
#import "UMSocial.h"
#import "Reachability.h"

#import "FHDiseaseDetailController.h"
#import "FHNavigationController.h"

//test
#import "FHDoctorInfoController.h"
#import "SVProgressHUD.h"
#import "FHNetworkTools.h"
#import "SDWebImageManager.h"



@interface AppDelegate()
//@property (nonatomic, strong) Reachability *reachability;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[FHSideMenu alloc] init];
    [self.window makeKeyAndVisible];
    
    
    //更改rootView
//        FHDiseaseDetailController *vc = [[FHDiseaseDetailController alloc]init];
//        FHNavigationController *nav = [[FHNavigationController alloc]initWithRootViewController:vc];
//        self.window.rootViewController  = nav;
    //test
    //    FHDoctorInfoController *doc=[[FHDoctorInfoController alloc]init];
    //        FHNavigationController *nav = [[FHNavigationController alloc]initWithRootViewController:doc];
    //    self.window.rootViewController = nav;
    
    //SDK 短信验证码  初始化应用，appKey和appSecret从后台申请得
    [SMSSDK registerApp:@"f00f31ff84b8" withSecret:@"0d17fb9bd5671d75fc5a05c5809e456e"];
    
    //友盟分享
    [UMSocialData setAppKey:@"56a1ebae67e58ee4550022de"];
    
    //[self setupNotification];
    
    return YES;
}

///**
// *  初始化通知
// */
//- (void)setupNotification{
//    [FHNotificationCenter addObserver:self selector:@selector(checkNetworkState) name:kReachabilityChangedNotification object:nil];
//    self.reachability = [Reachability reachabilityForInternetConnection];
//    [self.reachability startNotifier];
//}

/**
 *  检查网络状态
 */
- (void)checkNetworkState{
    if ([FHNetworkTools isEnableWIFI]) {
        NSLog(@"wifi环境");
        [SVProgressHUD showInfoWithStatus:@"wifi环境" maskType:SVProgressHUDMaskTypeGradient];
    }else if ([FHNetworkTools isEnable4G]) {
        NSLog(@"4G环境");
        [SVProgressHUD showInfoWithStatus:@"蜂窝环境" maskType:SVProgressHUDMaskTypeGradient];
    }else{
        NSLog(@"没有网络");
        [SVProgressHUD showInfoWithStatus:@"没有网络" maskType:SVProgressHUDMaskTypeGradient];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    //取消下载任务
    [mgr cancelAll];
    
    //清理内存
    [mgr.imageCache clearMemory];
}

@end





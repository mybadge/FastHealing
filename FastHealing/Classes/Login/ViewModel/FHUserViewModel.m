//
//  FHUserViewModel.m
//  FastHealing
//
//  Created by 赵志丹 on 16/1/21.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHUserViewModel.h"

#import "FHNetworkTools.h"
#import "UIWindow+Extension.h"

@implementation FHUserViewModel
static FHUserViewModel *_instence;

+ (instancetype)shareUserModel {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instence = [[FHUserViewModel alloc] init];
    });
    return _instence;
}

/**
 *  判断是否登录成功
 */
- (BOOL)isLogin {
    return self.user != nil;
}


- (void)loginDataWithBlock:(NSMutableDictionary *)params loginBlock:(LoginBlock)loginBlock {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"login_token"] = FHLoginToken;
    
    [dict addEntriesFromDictionary:params];
    //FHLog(@"loginDataWithBlock--dict====%@", dict);
    
    [[FHNetworkTools sharedNetworkTools] POST:@"http://iosapi.itcast.cn/carelinkQuickLogin.json.php" parameters:dict success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        //FHLog(@"%@", responseObject);
        if ([@"OK" isEqualToString:responseObject[@"msg"]]) {
            FHUser *user = [FHUser userWithDict:responseObject[@"data"]];
            self.user = user;
            loginBlock(user, @"登陆成功");
            
        }else if ([@"error" isEqualToString:responseObject[@"msg"]]) {
            loginBlock(nil, @"账号或密码错误");
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        loginBlock(nil, @"您网络有问题");
    }];
}

- (void)logout {
    self.user = nil;
    [[UIApplication sharedApplication].keyWindow switchRootViewController];
}
@end


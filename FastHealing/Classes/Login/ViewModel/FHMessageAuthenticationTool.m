//
//  FHMessageAuthenticationTool.m
//  FastHealing
//
//  Created by xiechen on 16/1/21.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHMessageAuthenticationTool.h"
#import <SMS_SDK/SMSSDK.h>
#import "SVProgressHUD.h"
@implementation FHMessageAuthenticationTool
static FHMessageAuthenticationTool *_message;

+ (instancetype)shareMessageAuthentication{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _message = [[FHMessageAuthenticationTool alloc]init];
    });
    return _message;
}


- (void)getMessageAuthenticationAccountField:(NSString *)account{
    [SVProgressHUD showWithStatus:@"正在发送" maskType:SVProgressHUDMaskTypeNone];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [SVProgressHUD dismiss];
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:account zone:@"86" customIdentifier:nil result:^(NSError *error) {
            if (!error) {
                [SVProgressHUD showSuccessWithStatus:@"请注意查收验证码"];
                NSLog(@"获取验证码成功");
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取验证码失败"];
                
                NSLog(@"获取验证码失败");
            }
        }];
        
    });
}

-(void)myCommitVerificationCodePwdText:(NSString *)pwd andAccountField:(NSString *)account myBlock:(Block)myBlock{
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeNone];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [SMSSDK commitVerificationCode:pwd phoneNumber:account zone:@"86" result:^(NSError *error) {
            
            if (!error) {
                [SVProgressHUD showSuccessWithStatus:@"验证成功"];
                if (myBlock) {
                    myBlock();
                }
                NSLog(@"验证成功");
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"验证失败"];
                
                NSLog(@"错误信息:%@",error);
            }
        }];
        
    });
}

@end

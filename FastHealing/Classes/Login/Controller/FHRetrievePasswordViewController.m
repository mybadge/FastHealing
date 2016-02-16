//
//  FHRetrievePasswordViewController.m
//  FastHealing
//
//  Created by 赵志丹 on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//
/**
 *  用户找回密码
 */
#import "FHRetrievePasswordViewController.h"
#import "SVProgressHUD.h"
#import <SMS_SDK//SMSSDK.h>
#import "FHMainViewController.h"
#import "FHMessageAuthenticationTool.h"
#import "FHResetPasswordViewController.h"
#import "UITextField+Extension.h"

@interface FHRetrievePasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@end

@implementation FHRetrievePasswordViewController
- (IBAction)nextBtnClick {
    FHLog(@"%s", __func__);
    //验证验证码
    [[FHMessageAuthenticationTool shareMessageAuthentication] myCommitVerificationCodePwdText:self.pwdField.text andAccountField:self.accountField.text myBlock:^{

        //跳转控制器
        [self performSegueWithIdentifier:@"resetPassword" sender:nil];
    }];
}
//获取验证码
- (IBAction)getVerificationCode:(UIButton *)sender {
    FHLog(@"%s", __func__);
    
    if (self.accountField.text.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"您输入的手机位数不符合"];
        return;
    }
    if (self.pwdField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请您输入密码"];
        return;
    }
    //TODO 获取验证码
    [[FHMessageAuthenticationTool shareMessageAuthentication] getMessageAuthenticationAccountField:self.accountField.text];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.accountField setLeftViewWithImageName:@"shouji"];
    [self.pwdField setLeftViewWithImageName:@"login_verification"];
    
    [self.accountField addTarget:self action:@selector(valueChange) forControlEvents:UIControlEventEditingChanged];
    [self.pwdField addTarget:self action:@selector(valueChange) forControlEvents:UIControlEventEditingChanged];
    [self valueChange];
}

- (void)valueChange{
    self.nextBtn.enabled = self.accountField.text.length > 0 && self.pwdField.text.length > 0;
}
@end

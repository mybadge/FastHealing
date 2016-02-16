//
//  FHLoginVerificationViewController.m
//  FastHealing
//
//  Created by 赵志丹 on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHLoginVerificationViewController.h"
#import "SVProgressHUD.h"
#import "FHMessageAuthenticationTool.h"
#import "FHMainViewController.h"
#import "UITextField+Extension.h"
#import "FHSideMenu.h"
#import "UIView+ViewController.h"
#import "FHUserViewModel.h"


@interface FHLoginVerificationViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@end

@implementation FHLoginVerificationViewController
- (IBAction)backClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.accountField setLeftViewWithImageName:@"shouji"];
    [self.pwdField setLeftViewWithImageName:@"login_verification"];
    
    [self.accountField addTarget:self action:@selector(valueChange) forControlEvents:UIControlEventEditingChanged];
    [self.pwdField addTarget:self action:@selector(valueChange) forControlEvents:UIControlEventEditingChanged];
    [self valueChange];
    
    self.loginBtn.enabled = YES;
    
}

- (void)valueChange{
    self.loginBtn.enabled = self.accountField.text.length > 0 && self.pwdField.text.length > 0;
}


- (IBAction)getVerificationCode:(UIButton *)sender {
    FHLog(@"%s", __func__);
    //TODO 获取验证码
    if (self.accountField.text.length == 11) {
        [SVProgressHUD showWithStatus:@"正在获取"];
        [[FHMessageAuthenticationTool shareMessageAuthentication] getMessageAuthenticationAccountField:self.accountField.text];
    }else{
        [SVProgressHUD showErrorWithStatus:@"输入的手机号码不正确"];
    }
    
}


- (IBAction)btnLoginClick:(UIButton *)sender {
    [self.view endEditing:YES];
    if (self.accountField.text.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"手机号码位数不符合"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在努力登录中..." maskType:SVProgressHUDMaskTypeBlack];
    
    
    FHUserViewModel *userViewModel = [FHUserViewModel shareUserModel];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"username"] = self.accountField.text;
    params[@"pwd"] = self.pwdField.text;
    [userViewModel loginDataWithBlock:params loginBlock:^(FHUser *user, NSString *result) {
        
        [SVProgressHUD dismiss];
        if (self.accountField.text.length == 11 && self.pwdField.text.length != 0) {
            
            [[FHMessageAuthenticationTool shareMessageAuthentication] myCommitVerificationCodePwdText:self.pwdField.text andAccountField:self.accountField.text myBlock:^{
                //跳到主界面
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    FHSideMenu *sideMenu = [sender getResponserClass:[FHSideMenu class]];
                    [sideMenu hideSideMenu];
                });
            }];
        }
    }];
}


@end

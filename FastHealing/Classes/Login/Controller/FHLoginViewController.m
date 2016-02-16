//
//  FHLoginViewController.m
//  FastHealing
//
//  Created by 赵志丹 on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHLoginViewController.h"
#import "SVProgressHUD.h"
#import "FHUserViewModel.h"
//#import "UIWindow+Extension.h"
#import "UITextField+Extension.h"
#import "UIView+ViewController.h"
#import "FHSideMenu.h"

@interface FHLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UISwitch *remPwdSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;

@end

@implementation FHLoginViewController
- (IBAction)btnLoginClick:(UIButton *)sender {
    
    [self.view endEditing:YES];
    [SVProgressHUD showWithStatus:@"正在努力登录中..." maskType:SVProgressHUDMaskTypeBlack];
    FHUserViewModel *userViewModel = [FHUserViewModel shareUserModel];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"username"] = self.accountField.text;
    params[@"pwd"] = self.pwdField.text;
    [userViewModel loginDataWithBlock:params loginBlock:^(FHUser *user, NSString *result) {
        
        [SVProgressHUD dismiss];
        if (user) {
            //登录成功
            NSUserDefaults *ud =[NSUserDefaults standardUserDefaults];
            [ud setObject:self.accountField.text forKey:kAccountFieldKey];
            
            [ud setBool:self.remPwdSwitch.isOn forKey:kRemPwdSwitchKey];
            [ud setBool:self.autoLoginSwitch.isOn forKey:kAutoLoginSwitchKey];
            
            if (self.remPwdSwitch.isOn) {
                [ud setObject:self.pwdField.text forKey:kPwdFieldKey];
            }
            //跳到主界面
            FHSideMenu *sideMenu = [sender getResponserClass:[FHSideMenu class]];
            [sideMenu hideSideMenu];
           
        } else {
            [SVProgressHUD showSuccessWithStatus:result];
        }
        
    }];    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.accountField setLeftViewWithImageName:@"shouji"];
    [self.pwdField setLeftViewWithImageName:@"login_Security"];
    
    
    
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    self.accountField.text = [userDefault objectForKey:kAccountFieldKey];
    self.remPwdSwitch.on = [userDefault boolForKey:kRemPwdSwitchKey];
    self.autoLoginSwitch.on = [userDefault boolForKey:kAutoLoginSwitchKey];
    
    if (self.remPwdSwitch.isOn) {
        self.pwdField.text = [userDefault objectForKey:kPwdFieldKey];
    }
    
    if (self.autoLoginSwitch.isOn) {
        [self btnLoginClick:nil];
    }
    
    
    [self.accountField addTarget:self action:@selector(valueChange) forControlEvents:UIControlEventEditingChanged];
    [self.pwdField addTarget:self action:@selector(valueChange) forControlEvents:UIControlEventEditingChanged];
    [self valueChange];
}

- (void)valueChange{
    self.loginBtn.enabled = self.accountField.text.length > 0 && self.pwdField.text.length > 0;
}

- (IBAction)remPwdChage:(UISwitch *)sender {
    if (!sender.isOn) {
        [self.autoLoginSwitch setOn:NO animated:YES];
    }
}

- (IBAction)autoLoginChage:(UISwitch *)sender {
    if (sender.isOn) {
        [self.remPwdSwitch setOn:YES animated:YES];
    }
}




@end

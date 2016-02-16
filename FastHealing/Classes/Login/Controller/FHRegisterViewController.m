//
//  FHRegisterViewController.m
//  FastHealing
//
//  Created by 赵志丹 on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHRegisterViewController.h"
#import "SVProgressHUD.h"
#import "FHMessageAuthenticationTool.h"
#import "UIWindow+Extension.h"
#import "FHMainViewController.h"
#import "UITextField+Extension.h"


@interface FHRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (weak, nonatomic) IBOutlet UILabel *agreementLable;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@end

@implementation FHRegisterViewController
- (IBAction)checkBoxClick:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}

//登录按钮
- (IBAction)btnLoginClick:(UIButton *)sender {
    [self.view endEditing:YES];
    FHLog(@"%s",__func__);
    if (self.accountField.text.length != 0 && self.pwdField.text.length != 0 && self.checkBtn.selected) {

        [[FHMessageAuthenticationTool shareMessageAuthentication] myCommitVerificationCodePwdText:self.pwdField.text andAccountField:self.accountField.text myBlock:^{
            
            [self performSegueWithIdentifier:@"LoginSuccessful" sender:nil];
        }];
    }
    //取消用户交互
    //self.loginBtn.userInteractionEnabled = NO;
}

- (IBAction)getVerificationCode:(UIButton *)sender {
    FHLog(@"%s", __func__);
    //TODO 获取验证码
    if (self.accountField.text.length == 11) {
        [SVProgressHUD showWithStatus:@"正在获取"];
         [[FHMessageAuthenticationTool shareMessageAuthentication] getMessageAuthenticationAccountField:self.accountField.text];
    }else{
        [SVProgressHUD showErrorWithStatus:@"输入的手机号码不符合"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self agreementsLable];

    [self.accountField setLeftViewWithImageName:@"shouji"];
    [self.pwdField setLeftViewWithImageName:@"login_verification"];
    [self.accountField addTarget:self action:@selector(valueChange) forControlEvents:UIControlEventEditingChanged];
    [self.pwdField addTarget:self action:@selector(valueChange) forControlEvents:UIControlEventEditingChanged];
    [self valueChange];
}


- (void)valueChange{
    self.loginBtn.enabled = self.accountField.text.length > 0 && self.pwdField.text.length > 0;
}



- (IBAction)back {
    [self.navigationController popViewControllerAnimated:YES];
}


//协议lable 的设置
- (void)agreementsLable{
    
    NSString *agreementStr = self.agreementLable.text;
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:agreementStr];
    NSRange range = [[attributeStr string] rangeOfString:@"用户协议"];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:range];
    
    [attributeStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithUnsignedInteger:NSUnderlineStyleSingle] range:range];
    
    self.agreementLable.attributedText = attributeStr;
    self.agreementLable.userInteractionEnabled = YES;
    

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(agreementClick)];
    
    [self.agreementLable addGestureRecognizer:tap];

}


- (void)agreementClick{
    

    UIWebView *web = [[UIWebView alloc]initWithFrame:self.view.bounds];
    web.backgroundColor = [UIColor whiteColor];
    NSURL *url = [NSURL URLWithString:@"http://www.datatang.com/ab/registerpact.aspx"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    web.scalesPageToFit = YES;
    [web loadRequest:request];
    
    UIViewController *webVC = [[UIViewController alloc]init];
    webVC.view = web;
    webVC.title = @"用户协议";

    [self.navigationController pushViewController:webVC animated:YES];

}

@end

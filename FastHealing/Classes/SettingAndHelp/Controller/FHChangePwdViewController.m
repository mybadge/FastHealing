//
//  FHChangePwdViewController.m
//  FastHealing
//
//  Created by xiechen on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHChangePwdViewController.h"
#import "SVProgressHUD.h"
#import "FHLoginViewController.h"
#import "UIWindow+Extension.h"
#import "FHUserViewModel.h"
@interface FHChangePwdViewController ()

@property (weak, nonatomic) IBOutlet UITextField *oen;
@property (weak, nonatomic) IBOutlet UITextField *two;
@property (weak, nonatomic) IBOutlet UITextField *san;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (nonatomic,strong)UIImageView *imageView;
@end

@implementation FHChangePwdViewController
//修改完成
- (IBAction)clickBtn:(id)sender {
    if (self.oen.text.length != 0 && self.two.text.length != 0 && self.san.text.length != 0 && [self.two.text isEqualToString:self.san.text] && ![self.oen.text isEqualToString:self.two.text]) {
        [SVProgressHUD showSuccessWithStatus:@"修改成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [UIApplication sharedApplication].keyWindow.rootViewController = FHLoginVC;
        });
    }
    if (self.oen.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入原始密码"];
    }else if (self.two.text.length == 0 || self.san.text.length == 0){
        [SVProgressHUD showErrorWithStatus:@"请输入新密码密码"];
    }else if (![self.two.text isEqualToString:self.san.text]){
        [SVProgressHUD showErrorWithStatus:@"两次输入密码不一致"];
    }else if ([self.oen.text isEqualToString:self.two.text]){
        [SVProgressHUD showErrorWithStatus:@"请设置与原密码不同的密码"];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFilChange) name:UITextFieldTextDidChangeNotification object:nil];
    
    //textFiel 1
    self.oen.leftView = [self imageview:@"login_info"];
    self.oen.leftViewMode = UITextFieldViewModeAlways;
    //textFiel 2
    self.two.leftView = [self imageview:@"login_info"];
    self.two.leftViewMode = UITextFieldViewModeAlways;
    //textFiel 3
    self.san.leftView = [self imageview:@"login_info"];
    self.san.leftViewMode = UITextFieldViewModeAlways;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}
- (void)textFilChange{
    if (self.oen.text.length != 0 && self.two.text.length != 0 && self.san.text.length != 0) {
        self.btn.userInteractionEnabled = YES;
    }
}
- (void)barbtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
//创建imageView
- (UIImageView *)imageview:(NSString *)imageName{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    imageView.bounds = CGRectMake(0, 0, 30, 30);
    return imageView;
}
@end

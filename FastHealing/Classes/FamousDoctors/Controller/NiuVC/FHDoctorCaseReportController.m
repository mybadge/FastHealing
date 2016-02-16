//
//  FHDoctorCaseReportController.m
//  FastHealing
//
//  Created by xianbinniu on 16/1/24.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHDoctorCaseReportController.h"
#import "FHDoctorCaseReportScrollView.h"
#import "UIView+Extension.h"
#import "FHSideMenu.h"



@interface FHDoctorCaseReportController ()

@property(nonatomic,weak)UIView *backView;

@end

@implementation FHDoctorCaseReportController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"递交资料";
    FHDoctorCaseReportScrollView *view=[FHDoctorCaseReportScrollView  loadCaseReportScrollView];
    view.frame=CGRectMake(0, 0, FHScreenSize.width, FHScreenSize.height-45);
    view.backgroundColor=FHColor(250, 250, 250);
    [self.view addSubview:view];
 UIButton  *btn = [[UIButton alloc]init];
    [btn addTarget:self action:@selector(BTnclick) forControlEvents:UIControlEventTouchUpInside];
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, FHScreenSize.height-45, FHScreenSize.width, 45)];
    btn.frame=CGRectMake(10, 5, backView.width-20, backView.height-10);
    [btn setBackgroundImage:[UIImage imageNamed:@"login_button_Normal-state"] forState:UIControlStateNormal];
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    [backView addSubview:btn];
    self.backView=backView;
    backView.backgroundColor=FHColor(240, 240, 240);
    [self.view addSubview:backView];
    //键盘通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
-(void)textchange:(NSNotification *)noti{
    NSLog(@"%@",noti.userInfo);
    /*
     UIKeyboardFrameBeginUserInfoKey = NSRect: {{0, 667}, {375, 258}},
     UIKeyboardCenterEndUserInfoKey = NSPoint: {187.5, 538},
     UIKeyboardBoundsUserInfoKey = NSRect: {{0, 0}, {375, 258}},
     UIKeyboardFrameEndUserInfoKey = NSRect: {{0, 409}, {375, 258}},
     UIKeyboardAnimationDurationUserInfoKey = 0.25,
     UIKeyboardCenterBeginUserInfoKey = NSPoint: {187.5, 796},
     UIKeyboardAnimationCurveUserInfoKey = 7,
     UIKeyboardIsLocalUserInfoKey = 1
     */
  NSValue *value=noti.userInfo[@"UIKeyboardFrameEndUserInfoKey"];
    CGRect rect=[value CGRectValue];
    [UIView animateWithDuration:0.25 animations:^{
        //设置动画曲线值,
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        self.backView.y=rect.origin.y-45;
    }];
}
-(void)BTnclick{
    
    UIAlertController *alert= [UIAlertController alertControllerWithTitle:@"上传病例成功" message:nil preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *action1=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [UIApplication sharedApplication].keyWindow.rootViewController=[[FHSideMenu alloc]init];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

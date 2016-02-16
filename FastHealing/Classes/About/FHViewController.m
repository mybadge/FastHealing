//
//  FHViewController.m
//  FastHealing
//
//  Created by xiechen on 16/1/21.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHViewController.h"
#import "FHApplyForHelpController.h"
#import "FHPictureByController.h"
#import "FHNetworkTools.h"
#import "FHPictureModel.h"
#import "FHPagerWebViewController.h"

@interface FHViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *lableName;
@property (weak, nonatomic) IBOutlet UILabel *acessLable;
@property (weak, nonatomic) IBOutlet UIButton *userBtnn;
@property (nonatomic,strong)NSArray *model;

@end

@implementation FHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"关于产品";
    
    UIImage *image = [UIImage imageNamed:@"about_protocol"];
    UIImageView *iamgeViewss = [[UIImageView alloc]initWithImage:image];
    iamgeViewss.frame = CGRectMake(15, 3.5, 23, 27);
    [self.userBtnn addSubview:iamgeViewss];

    NSMutableAttributedString *hintString = [[NSMutableAttributedString alloc]initWithString:@"用户交流:QQ8234829734"];
    
    NSRange range = [[hintString string]rangeOfString:@"QQ8234829734"];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor purpleColor] range:range];
    
    self.lableName.attributedText = hintString;
    self.lableName.userInteractionEnabled = YES;//开启lable的用户交互
    
    //给lable添加手势
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lableClick)];
    [self.lableName addGestureRecognizer:recognizer];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"right"]];
    imageView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 40, 0, 31, 31);
    
    [self.userBtnn addSubview:imageView];
    //创建导航栏的左边按钮
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftBtn setImage:[UIImage imageNamed:@"nav_return"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    
}


- (void)leftBtnClick{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dismissVC" object:nil userInfo:nil];
}


- (void)lableClick{
    //打开QQ
    NSLog(@"打开QQ应用");
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mqq://"]];
}

- (void)btnClick{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dismissVC" object:nil userInfo:nil];
}

- (IBAction)UserBtn:(id)sender {
    FHPagerWebViewController *webvc = [[FHPagerWebViewController alloc] init];
    webvc.html = @"agreement.html";
    webvc.title = @"预约须知";
    [self.navigationController pushViewController:webvc animated:YES];
}
@end

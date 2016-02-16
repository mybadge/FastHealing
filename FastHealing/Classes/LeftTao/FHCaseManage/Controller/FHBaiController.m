//
//  FHBaiController.m
//  FastHealing 
//
//  Created by tao on 16/1/21.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHBaiController.h"

@interface FHBaiController ()

@end

@implementation FHBaiController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNav];
    UIWebView *web = [[UIWebView alloc]init];
    self.view = web;
    //设置请求
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [web loadRequest:request];
    
    
    
}

//设置导航栏
- (void)setNav{
    //设置导航的左边按钮
    self.title = @"病例管理";
    //创建导航栏的左边按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //一定要设置大小
    [leftBtn sizeToFit];
    
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
}

- (void)leftBtnClick{
    //NSLog(@"dinji");
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

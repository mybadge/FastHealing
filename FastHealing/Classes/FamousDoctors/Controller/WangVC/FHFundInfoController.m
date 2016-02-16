//
//  FHFundInfoController.m
//  FastHealing
//
//  Created by 王 on 16/1/22.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHFundInfoController.h"

@interface FHFundInfoController ()

@end

@implementation FHFundInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置webview
    UIWebView *webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    webView.backgroundColor = [UIColor redColor];
    NSString *path = [[NSBundle mainBundle]pathForResource:self.htmlName ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    [self.view addSubview:webView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

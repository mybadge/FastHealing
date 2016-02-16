//
//  FHInstructionsViewController.m
//  FastHealing
//
//  Created by xiechen on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHInstructionsViewController.h"

@interface FHInstructionsViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation FHInstructionsViewController

- (void)viewDidLoad {
    self.title = @"加号服务";

    [super viewDidLoad];
    self.webView.delegate = self;
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.webView.scalesPageToFit = YES;
    [self.webView loadRequest:request];
}

#pragma mark - UIWebView的代理方法

@end

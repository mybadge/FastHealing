//
//  FHPagerWebViewController.m
//  FastHealing
//
//  Created by 赫腾飞 on 16/1/21.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHPagerWebViewController.h"
#import "UIWebView+AFNetworking.h"

@interface FHPagerWebViewController ()
@end

@implementation FHPagerWebViewController

- (void)loadView {
    self.view = [[UIWebView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSURL *url = nil;
    if (self.URLString == nil && self.html != nil) {
        url = [[NSBundle mainBundle] URLForResource:self.html withExtension:nil];
    }else if (self.URLString != nil){
      url =[NSURL URLWithString:self.URLString];
    
    }
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIWebView *webView = (UIWebView *)self.view;

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request progress:nil success:nil failure:nil];
}


@end

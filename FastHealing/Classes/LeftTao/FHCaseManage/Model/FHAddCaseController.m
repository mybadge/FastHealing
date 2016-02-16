//
//  FHAddCaseController.m
//  FastHealing
//
//  Created by tao on 16/1/25.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHAddCaseController.h"

@interface FHAddCaseController ()

@end

@implementation FHAddCaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
   // self.view.frame = CGRectMake(0, 68, FHScreenSize.width, FHScreenSize.height);
    [self setupUI];
    
}



- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    [self setupScrollView];
    
}

//设置ScrollView
- (void)setupScrollView{
    
}


@end














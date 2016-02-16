//
//  FHPublicBenefitController.m
//  FastHealing
//
//  Created by 王 on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHPublicBenefitController.h"
#import "Masonry.h"
#import "FHCNChildFoundationButton.h"
#import "FHApplyForHelpController.h"
#import "FHFundInfoController.h"

#define BUTTON_HEIGHT 40
#define BUTTON_MARGIN 100

@interface FHPublicBenefitController ()

@end

@implementation FHPublicBenefitController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置公益页布局
    [self decorateUI];
    

}

//设置公益页布局
- (void)decorateUI {
    //设置标题
    self.title = @"公益活动";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置背景图片
    UIView *backView = [[UIView alloc]init];
//    backView.backgroundColor = [UIColor redColor];
    [self.view addSubview:backView];
    UIImageView *imageView = [[UIImageView alloc]init];
    [backView addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"pubulicBenefit_backView"];
//    [imageView sizeToFit];
//    self.view.layer.contents = CFBridgingRelease([UIImage imageNamed:@"pubulicBenefit_backView"].CGImage);
    //设置申请援助,关于基金按钮
    UIButton *applyForHelp = [[UIButton alloc]init];
    applyForHelp.backgroundColor = FHPublicBenefitColor;
    [applyForHelp setTitle:@"申请援助" forState:UIControlStateNormal];
    [applyForHelp setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:applyForHelp];
    [applyForHelp addTarget:self action:@selector(applyForHelpButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *aboutFund = [[UIButton alloc]init];
    aboutFund.backgroundColor = [UIColor whiteColor];
    [aboutFund setTitle:@"关于基金" forState:UIControlStateNormal];
    [aboutFund setTitleColor:FHPublicBenefitColor forState:UIControlStateNormal];
    [self.view addSubview:aboutFund];
    [aboutFund addTarget:self action:@selector(aboutFundButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //设置中国少年基金会和启智基金按钮
    FHCNChildFoundationButton *CNChildFoundation = [[FHCNChildFoundationButton alloc]init];
    [CNChildFoundation buttonWithImageAboveTitleDown:[UIImage imageNamed:@"1"] title:@"客服:010-57288368"];
    [CNChildFoundation setTitleColor:FHPublicBenefitColor forState:UIControlStateNormal];
    [self.view addSubview:CNChildFoundation];
    [CNChildFoundation addTarget:self action:@selector(CNChildFoundationButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    FHCNChildFoundationButton *enlightenIntelligent = [[FHCNChildFoundationButton alloc]init];
    [enlightenIntelligent buttonWithImageAboveTitleDown:[UIImage imageNamed:@"2"] title:@"关于我们"];
    [enlightenIntelligent setTitleColor:FHPublicBenefitColor forState:UIControlStateNormal];
    [self.view addSubview:enlightenIntelligent];
    [enlightenIntelligent addTarget:self action:@selector(enlightenIntelligentButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //设置约束
    //背景图片的约束
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
    
    [applyForHelp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(FHScreenSize.height / 4);
        make.left.equalTo(self.view).offset(BUTTON_MARGIN);
        make.right.equalTo(self.view).offset(-BUTTON_MARGIN);
        make.height.mas_equalTo(BUTTON_HEIGHT);
        
    }];
    [aboutFund mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(applyForHelp.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(BUTTON_MARGIN);
        make.right.equalTo(self.view).offset(-BUTTON_MARGIN);
        make.height.mas_equalTo(BUTTON_HEIGHT);
        
    }];
    [CNChildFoundation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-50);
        make.right.equalTo(self.view.mas_centerX).offset(-5);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(50);
    }];
    [enlightenIntelligent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_centerX).offset(5);
        make.centerY.equalTo(CNChildFoundation.mas_centerY);
        make.width.equalTo(CNChildFoundation.mas_width);
        make.height.equalTo(CNChildFoundation.mas_height);
    }];
    
}

//申请援助按钮点击事件
- (void)applyForHelpButtonClick {

    FHApplyForHelpController *vc = [[FHApplyForHelpController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

//关于基金按钮点击事件
- (void)aboutFundButtonClick {

    FHFundInfoController *vc = [[FHFundInfoController alloc]init];
    vc.htmlName = @"aboutFund";
    [self.navigationController pushViewController:vc animated:YES];
}

//中国少年基金会按钮点击事件
- (void)CNChildFoundationButtonClick {

    FHFundInfoController *vc = [[FHFundInfoController alloc]init];
    vc.htmlName = @"CNChildFund";
    [self.navigationController pushViewController:vc animated:YES];
}

//启智基金按钮点击事件
- (void)enlightenIntelligentButtonClick {

    FHFundInfoController *vc = [[FHFundInfoController alloc]init];
    vc.htmlName = @"elightenFund";
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

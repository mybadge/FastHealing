//
//  FHCaseFloderController.m
//  FastHealing
//
//  Created by tao on 16/1/25.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHCaseFloderController.h"
#import "FHAddCaseController.h"
#import "FHAddCaseTC.h"
#import "FHAddCaseTableViewController.h"
#import "FHPersonHeaderDetail.h"
#import "FHUserViewModel.h"

@interface FHCaseFloderController ()
@property (weak, nonatomic) IBOutlet FHPersonHeaderDetail *personHeadView;
/**
 *  添加病例按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *caseSickBtn;

@end

@implementation FHCaseFloderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"病例管理";
    self.personHeadView.user = [FHUserViewModel shareUserModel].user;
    
    [self.caseSickBtn setTitle:@"添加病例" forState:UIControlStateNormal];
    [self.caseSickBtn setTitleColor:FHThemeColor forState:UIControlStateNormal];
    self.caseSickBtn.backgroundColor = [UIColor whiteColor];
    
    self.caseSickBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    
    [self.caseSickBtn setImage:[UIImage imageNamed:@"doctor_add_small"] forState:UIControlStateNormal];
    
}



- (IBAction)addCaseBtnClick:(id)sender {
    
    NSLog(@"添加病例");
    
    //    FHAddCaseController *addView = [[FHAddCaseController alloc]init];
    //    [self.navigationController pushViewController:addView animated:YES];
    
    //    FHAddCaseTC *addvc = [[FHAddCaseTC alloc]init];
    //    [self.navigationController pushViewController:addvc animated:YES];
    
    
    FHAddCaseTableViewController *addvc = [[FHAddCaseTableViewController alloc]init];
    addvc.title = @"添加病例";
    [self.navigationController pushViewController:addvc animated:YES];
    
}

@end

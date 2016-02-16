//
//  FHDoctorInfoController.m
//  FastHealing
//
//  Created by xianbinniu on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHDoctorInfoController.h"
#import "FHDoctorBasicInfoView.h"
#import "FHDoctorInfoModel.h"
#import "FHDoctorDetailInfoView.h"
#import "FHDoctorRecModel.h"
#import "FHDoctorIntro.h"
#import "SVProgressHUD.h"
#import "FHNetworkTools.h"
#import "FHInputIDController.h"
#import "FHDoctorCaseReportController.h"

@interface FHDoctorInfoController ()
//个人信息
@property(nonatomic,strong) FHDoctorBasicInfoView *infoView;
//详情信息
@property(nonatomic,strong) FHDoctorDetailInfoView *DetailView;
//按钮
@property(nonatomic,strong)UIButton *Btn;
//当前医生额ID
@property(nonatomic,strong)NSNumber *doctor_id;
@end

@implementation FHDoctorInfoController

- (void)viewDidLoad {

    [super viewDidLoad];
    self.title=@"医生简介";
    //需要添加点击
    UIButton *btn=[[UIButton alloc]init];
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//     [btn setTitle:@"收藏" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"icon_pathMenu_collect_normal"]  forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addTarget:self action:@selector(SubScribe) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.Btn=btn;
    //个人信息
    FHDoctorBasicInfoView *infoView = [FHDoctorBasicInfoView loadDoctorBasicInfoView];
    self.infoView = infoView;
    infoView.frame = CGRectMake(0, 64, FHScreenSize.width, 120);
    [self.view addSubview:infoView];
    //详情信息
    FHDoctorDetailInfoView *DetailView = [FHDoctorDetailInfoView loadDoctorDetailInfoView];
    self.DetailView = DetailView;
    DetailView.frame = CGRectMake(0, CGRectGetMaxY(infoView.frame)+20, FHScreenSize.width, FHScreenSize.height-(CGRectGetMaxY(infoView.frame)+20));
    [self.view addSubview:DetailView];
    self.view.backgroundColor = FHColor(240, 240, 240);
    //加在网络数据
    [self loadAllDoctorInfo];
    
   self.infoView.DoctoeModel = self.model;
    self.doctor_id = self.paramDict[@"doctor_id"];
    //注册通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushVC) name:@"niu" object:nil];
    //注册通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushVC1) name:@"case" object:nil];
}
-(void)pushVC1{
    FHDoctorCaseReportController *vc=[[FHDoctorCaseReportController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)pushVC{
    FHInputIDController *vc=[[FHInputIDController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
//收藏医生
-(void)SubScribe{
    UILabel *lable = [[UILabel alloc]init];
    lable.textColor=[UIColor whiteColor];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.frame= CGRectMake((FHScreenSize.width-200)/2, FHScreenSize.height-180, 200, 50);
    [self.view addSubview:lable];
    lable.layer.cornerRadius=25;
    lable.backgroundColor=[UIColor blackColor];
    lable.layer.masksToBounds=YES;
    lable.alpha=0;
    ;
    if (self.Btn.tag==1) {
        [self.Btn setImage:[UIImage imageNamed:@"icon_pathMenu_collect_highlighted"] forState:UIControlStateNormal];
     
        //添加关注医生
        lable.text=@"医生收藏成功";
          NSDictionary *dict=@{@"login_token":self.paramDict[@"login_token"],@"user_id":self.paramDict[@"user_id"],@"doctor_id":self.doctor_id};
        [[FHNetworkTools sharedNetworkTools] addDoctorWithDict:dict andSuccess:^(bool success) {
            //收藏成功的动画;
            if (success) {
                   self.Btn.tag=0;
                [UIView animateWithDuration:1 animations:^{
                    lable.alpha=0.6;
                } completion:^(BOOL finished) {
                    
                    [UIView animateWithDuration:1 animations:^{
                        lable.alpha=0;
                    } completion:^(BOOL finished) {
                        [lable removeFromSuperview];
                        
                    }];
                }];
            }
        } andFailure:^(NSError *error) {
            
        }];
    }
    if(self.Btn.tag==0)
       {
           [self.Btn setImage:[UIImage imageNamed:@"icon_pathMenu_collect_normal"]  forState:UIControlStateNormal];
          
        UIAlertController *alert= [UIAlertController alertControllerWithTitle:@"是否取消关注" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action0=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            return;
        }];
        UIAlertAction *action1=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //删除关注的医生
            [[FHNetworkTools sharedNetworkTools] deleteDoctorWithDict:nil andSuccess:^(bool success) {
                //删除收藏成功的动画;
                if (success) {
                     self.Btn.tag=1;
                    [UIView animateWithDuration:1 animations:^{
                        lable.alpha=0.6;
                    } completion:^(BOOL finished) {
                        
                        [UIView animateWithDuration:1 animations:^{
                            lable.alpha=0;
                        } completion:^(BOOL finished) {
                            [lable removeFromSuperview];
                            
                        }];
                    }];
                }
            } andFailure:^(NSError *error) {
                
            }];
        }];
        [alert addAction:action0];
        [alert addAction:action1];
        [self presentViewController:alert animated:YES completion:nil];
        lable.text=@"成功取消关注医生";
    }
}
-(void)loadAllDoctorInfo{
    [SVProgressHUD show];
    //医生信息模块 参数为外接口;
//    NSDictionary *dict1=@{@"login_token":self.paramDict[@"login_token"],@"user_id":self.paramDict[@"user_id"],@"doctor_id":self.paramDict[@"doctor_id"]};
//    [[FHNetworkTools sharedNetworkTools] getDoctorInfoWithDict:dict1 andSuccess:^(FHDoctorInfoModel *DocInfoModel) {
////        self.infoView.DoctoeModel = DocInfoModel;
//        //拿到医生的ID;
//        self.doctor_id=DocInfoModel.doctor_id;
//    } andFailure:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
    //就诊条件模块
      NSDictionary *dict2=@{@"login_token":self.paramDict[@"login_token"],@"doctor_id":self.paramDict[@"doctor_id"]};
    
    [[FHNetworkTools sharedNetworkTools] getDoctorReceivingSettingWithDict:dict2 andSuccess:^(FHDoctorRecModel *DocInfoModel) {
        self.DetailView.RecModel = DocInfoModel;
        
    } andFailure:^(NSError *error) {
//        NSLog(@"%@",error);
    }];
    //医生介绍
       NSDictionary *dict3=@{@"login_token":self.paramDict[@"login_token"],@"doctor_id":self.paramDict[@"doctor_id"]};
    [[FHNetworkTools sharedNetworkTools] getDoctorIntroductionWithDict:dict3 andSuccess:^(FHDoctorIntro *DocInfoModel) {
        self.DetailView.DoctorModel = DocInfoModel;
    } andFailure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    //就诊时间选择(医生值班信息)
    [[FHNetworkTools sharedNetworkTools]matchDoctorDutiesWithDict:@{@"login_token":self.paramDict[@"login_token"],@"doctor_id":self.paramDict[@"doctor_id"]} andSuccess:^(FHDoctorRecTimeModel *model) {
        self.DetailView.DoctorRecTimeModel=model;
    } andFailure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    //判断是否关注
      NSDictionary *dict4=@{@"login_token":self.paramDict[@"login_token"],@"user_id":self.paramDict[@"user_id"],@"page_size":@(15),@"page":@(1)};
    [[FHNetworkTools sharedNetworkTools]getDoctorListWithDict:dict4 andSuccess:^(NSArray *datalist) {
//        NSLog(@"%@",datalist);
        //判断是否在数组里
        if ( [datalist containsObject:self.doctor_id]) {
             [self.Btn setImage:[UIImage imageNamed:@"icon_pathMenu_collect_highlighted"] forState:UIControlStateNormal];
            self.Btn.tag=0;
        }else{
             [self.Btn setImage:[UIImage imageNamed:@"icon_pathMenu_collect_normal"]  forState:UIControlStateNormal];
            self.Btn.tag=1;
        }
        
    } andFailure:^(NSError *error) {
        
    }];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end

//
//  FHMatchDoctorsController.m
//  FastHealing
//
//  Created by xianbinniu on 16/1/21.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHMatchDoctorsController.h"
#import "FHMatchDoctorsCell.h"
#import "FHDoctorInfoModel.h"
#import "FHDoctorInfoController.h"

#import "FHNetworkTools.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"


@interface FHMatchDoctorsController ()
//匹配到所有的医生信息
@property(nonatomic,strong) NSMutableArray *MatchDoctors;
//记录刷新的次数
@property(nonatomic,assign)int  CurrentPage;

@end
@implementation FHMatchDoctorsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"选择医生";
//    self.tableView.estimatedRowHeight = 80;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.rowHeight = 80;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.CurrentPage =[self.paramDict[@"page"] intValue];
  //第一次加载数据
    [self loadData];
    //上啦刷新
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self Uprefreash];
    }];
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.tableView.mj_header endRefreshing];
    }];

}
//第一次加载数据
-(void)loadData{
    [SVProgressHUD showWithStatus:@"加载数据中..."];
    [[FHNetworkTools sharedNetworkTools]matchDoctorsIntroductionWithDict:self.paramDict andSuccess:^(NSArray *dalalist) {
        //无匹配的医生
        if (dalalist==nil) {
            UILabel *lable = [[UILabel alloc]init];
            lable.text=@"没有匹配的医生";
            lable.textColor=[UIColor whiteColor];
            lable.textAlignment = NSTextAlignmentCenter;
            lable.frame= CGRectMake((FHScreenSize.width-200)/2, FHScreenSize.height-180, 200, 40);
            [self.view addSubview:lable];
            lable.layer.cornerRadius=25;
            lable.backgroundColor=[UIColor blackColor];
            lable.layer.masksToBounds=YES;
            lable.alpha=0;
            lable.center=self.view.center;
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
        [SVProgressHUD dismiss];
       
        self.MatchDoctors=dalalist.mutableCopy;
        [self.tableView reloadData];
    } andFailure:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"%@",error);
    }];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}
//上拉刷新
-(void)Uprefreash{
    if (self.CurrentPage>=3){
        [self.tableView.mj_footer endRefreshing];
        return;
    }
        self.CurrentPage++;
      NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithDictionary:self.paramDict];
    
        dict[@"page"]=@(self.CurrentPage);
        self.paramDict=dict.copy;
        
        [[FHNetworkTools sharedNetworkTools]matchDoctorsIntroductionWithDict:self.paramDict andSuccess:^(NSArray *dalalist) {
            [self.tableView.mj_footer endRefreshing];
             NSLog(@"%ld",dalalist.count);
            for (FHDoctorInfoModel *model in dalalist) {
                [self.MatchDoctors insertObject:model atIndex:self.MatchDoctors.count];
            }
            [self.tableView reloadData];
        } andFailure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
 
    
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.MatchDoctors.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FHMatchDoctorsCell *cell = [FHMatchDoctorsCell cellWithTableView:tableView];
  FHDoctorInfoModel *model=self.MatchDoctors[indexPath.row];
    cell.DoctorInfoModel=model;
    return cell;
}
#pragma mark -Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FHDoctorInfoModel *model=self.MatchDoctors[indexPath.row];
    FHDoctorInfoController *docVC = [[FHDoctorInfoController alloc]init];
    docVC.model=model;
    
    //    NSDictionary *paramDic = @{@"login_token":FHLoginToken,@"ci1_id":@(1),@"ci2_id":@(3),@"ci3_id":@(3),@"diagnosis_type":@(0),@"is_confirmed":@(1),@"user_id":@(1000089),@"complications":@[@"1",@"",@"",@"",@"",@""],@"has_diagnosis":@(2),@"page":@(3)};
    //参数
docVC.paramDict=@{@"login_token":FHLoginToken,@"user_id":self.paramDict[@"user_id"],@"doctor_id":model.doctor_id};
    [self.navigationController pushViewController:docVC animated:YES];
}

@end

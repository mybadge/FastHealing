//
//  FHFamousDoctorsTC.m
//  FastHealing
//
//  Created by tao on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHFamousDoctorsTC.h"
#import "FHFamousModel.h"
#import "FHTFamousCell.h"
@interface FHFamousDoctorsTC ()
@property (strong, nonatomic) NSArray *famousModelArr;
@property (strong, nonatomic) NSArray *dictArr;
@end

@implementation FHFamousDoctorsTC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    self.tableView.rowHeight = 100;
    //self.tableView.
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
   // self.tableView.separatorInset = UIEdgeInsetsMake(10, 0, 0, 0);
    
    //self.tableView.sectionHeaderHeight = 10;
    //自定义字典:
  self.dictArr = [self setUpDictArray];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark 实现数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.famousModelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FHTFamousCell *cell = [FHTFamousCell famousCellWith:tableView];
    FHFamousModel *model = self.famousModelArr[indexPath.row];
    cell.famousModel = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark 实现点击cell的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了famousDoctorsTC里面的cell");
}


/**
 @property (copy, nonatomic) NSString *true_name;
@property (copy, nonatomic) NSString *duty_date;
@property (copy, nonatomic) NSString *ci3_name;
@property (copy, nonatomic) NSString *doctor_name;
@property (copy, nonatomic) NSString *doctor_title_name;
@property (copy, nonatomic) NSString *hospital_name;
@property (copy, nonatomic) NSString *order_status;
 */


//自定义数据
- (NSArray *)setUpDictArray{
    NSMutableArray *arrM = [NSMutableArray array];
    NSDictionary *dict1 = @{@"true_name":@"王会森",@"duty_date":@"2015-09-09 上午",@"ci3_name":@"高血压",@"doctor_name":@"放得开",@"doctor_title_name":@"厨师",@"hospital_name":@"北京协和医院",@"order_status":@"审核中"};
    NSDictionary *dict2 = @{@"true_name":@"孙菲菲",@"duty_date":@"2015-08-24 下午",@"ci3_name":@"高血压",@"doctor_name":@"喝咖啡",@"doctor_title_name":@"司机",@"hospital_name":@"北京协和医院",@"order_status":@"匹配中"};
    NSDictionary *dict3 = @{@"true_name":@"发布森",@"duty_date":@"2015-08-09 上午",@"ci3_name":@"高血脂",@"doctor_name":@"司法局",@"doctor_title_name":@"师傅",@"hospital_name":@"北京协和医院",@"order_status":@"申请成功"};
    NSDictionary *dict4 = @{@"true_name":@"王会森",@"duty_date":@"2015-07-06 下午",@"ci3_name":@"高血压",@"doctor_name":@"杜可风",@"doctor_title_name":@"主治医师",@"hospital_name":@"山东蓝翔医院",@"order_status":@"申请失败"};
    NSDictionary *dict5 = @{@"true_name":@"瓦房河",@"duty_date":@"2015-06-09 上午",@"ci3_name":@"高血压",@"doctor_name":@"书法家",@"doctor_title_name":@"付快递费",@"hospital_name":@"北京新东方医院",@"order_status":@"已就诊"};
    NSDictionary *dict6 = @{@"true_name":@"瓦房河",@"duty_date":@"2015-06-09 上午",@"ci3_name":@"高血压",@"doctor_name":@"书法家",@"doctor_title_name":@"付快递费",@"hospital_name":@"北京新东方医院",@"order_status":@"申请失败"};
    NSDictionary *dict7 = @{@"true_name":@"瓦房河",@"duty_date":@"2015-06-09 上午",@"ci3_name":@"高血压",@"doctor_name":@"书法家",@"doctor_title_name":@"付快递费",@"hospital_name":@"北京新东方医院",@"order_status":@"已就诊"};
    [arrM addObject:dict1];
    [arrM addObject:dict2];
    [arrM addObject:dict3];
    [arrM addObject:dict4];
    [arrM addObject:dict5];
    [arrM addObject:dict6];
    [arrM addObject:dict7];
    return arrM.copy;
    
}


#pragma mark 懒加载
- (NSArray *)dictArr{
    if (_dictArr == nil) {
        _dictArr = [NSArray array];
    }
    return _dictArr;
}

//模型数组
- (NSArray *)famousModelArr{
    if (_famousModelArr == nil) {
        _famousModelArr = [NSArray array];
        NSMutableArray *arrM = [NSMutableArray array];
        //遍历数组字典转模型
        for (NSDictionary *dict in self.dictArr) {
            FHFamousModel *model = [FHFamousModel famousModelWithDict:dict];
            [arrM addObject:model];
        }
        _famousModelArr = arrM.copy;
    }
    return _famousModelArr;
}


//设置导航栏
- (void)setNav{
    //设置导航的左边按钮
    self.title = @"病例列表";
    //创建导航栏的左边按钮
   UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
   // leftBtn.frame = CGRectMake(0, 0, 30, 30);
   // [leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"nav_return"] forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //一定要设置大小
    //[leftBtn sizeToFit];
    
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
}

//实现导航栏左边按钮的点击事件

- (void)leftBtnClick{
    //NSLog(@"点解了左边的按钮");
    //发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dismissVC" object:nil];
    
    //[self.navigationController popToViewController:self.navigationController.childViewControllers[1] animated:YES];
}

@end

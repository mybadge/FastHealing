//
//  FHChooseDiseasePopController.m
//  FastHealing
//
//  Created by 王 on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHChooseDiseasePopController.h"
#import "FHDiseaseModel.h"
#import "Masonry.h"
#import "FHSalvageBasicInfoController.h"

@interface FHChooseDiseasePopController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation FHChooseDiseasePopController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置数据源代理
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.disease.diseaseList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = self.disease.diseaseList[indexPath.row];
    // Configure the cell...
    
    return cell;
}

//设置header
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
    view.backgroundColor = [UIColor grayColor];
    
    UILabel *title = [[UILabel alloc]init];
    title.text = self.disease.title;
    title.textColor = FHPublicBenefitColor;
    [view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(10);
        make.top.equalTo(view.mas_top).offset(5);
    }];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}


//tableview代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"%ld",indexPath.row);
//    NSLog(@"%@",self.disease.diseaseList[indexPath.row]);
    //代理传值,将疾病大类和具体名称传过去
    if ([self.delegate respondsToSelector:@selector(chooseDiseasePopController:diseaseTitle:andDiseaseName:)]) {
        [self.delegate chooseDiseasePopController:self diseaseTitle:self.disease.title andDiseaseName:self.disease.diseaseList[indexPath.row]];
    }

}



@end

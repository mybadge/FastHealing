//
//  FHAddCaseTC.m
//  FastHealing
//
//  Created by tao on 16/1/25.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHAddCaseTC.h"

@interface FHAddCaseTC ()

@end

@implementation FHAddCaseTC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.tableHeaderView.hidden = 0;
    self.view.backgroundColor = [UIColor blueColor];
    self.tableView.tableHeaderView = [[UIView alloc]init];
   // UITableView *view = [UITableView alloc]
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 实现数据源

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
    
}

//每组数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
       
        return 2;
    }else {
        return 1;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.text = @"sfsf";
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 100;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

@end
















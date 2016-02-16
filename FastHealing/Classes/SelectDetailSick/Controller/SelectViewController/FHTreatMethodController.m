//
//  FHTreatMethodController.m
//  FastHealing
//
//  Created by ZhangZiang on 16/1/21.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHTreatMethodController.h"

@interface FHTreatMethodController ()

@end

@implementation FHTreatMethodController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择治疗方式";
    self.tableView.separatorInset = UIEdgeInsetsMake(0,0, 0, 0);
    [self.tableView registerClass:UITableViewCell.self forCellReuseIdentifier:@"TreatMethod"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TreatMethod" forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"手术治疗";
            break;
        case 1:
            cell.textLabel.text = @"保守治疗";
            break;
        case 2:
            cell.textLabel.text = @"药物治疗";
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    NSInteger tag = 0;
    
    switch (indexPath.row) {
        case 0:
            tag = 2;
            break;
        case 1:
            tag = 3;
            break;
        case 2:
            tag = 4;
            break;
        default:
            break;
    }

    if (self.blockSelected) {
        self.blockSelected(tag);
    }
}
#pragma mark 取消分割线左边的空白间距
-(void)viewDidLayoutSubviews {
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
@end

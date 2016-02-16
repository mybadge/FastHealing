//
//  FHChangeBigCaseTC.m
//  FastHealing
//
//  Created by tao on 16/1/26.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHChangeBigCaseTC.h"
#import "FHChangeBigCaseModel.h"

@interface FHChangeBigCaseTC ()
@property (strong, nonatomic) NSArray *modelArray;
@end

@implementation FHChangeBigCaseTC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc]init];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"changeBigCase"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"changeBigCase"];
    }
    
    
    switch (indexPath.row + 1) {
        case 1:
            cell.textLabel.text = @"肿瘤";
            break;
        case 2:
            cell.textLabel.text = @"血液科";
            break;
        case 3:
            cell.textLabel.text = @"心血管";
            break;
        case 4:
            cell.textLabel.text = @"神经科";
            break;
        case 5:
            cell.textLabel.text = @"骨科";
            break;
            
        default:
            break;
    }
    
  return cell;
}





//点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //获得点击的cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSInteger ci1_id = indexPath.row + 1;
    //caseName;
    //ci1_id;
    NSDictionary *dict = @{
                           @"caseName":cell.textLabel.text,@"ci1_id":@(ci1_id)
                           };
    
    
    FHChangeBigCaseModel *model = [FHChangeBigCaseModel changeBigCaseModelWithDict:dict];

    if (self.changeBlock) {
        self.changeBlock(model);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark 懒加载
/**
 肿瘤     ci1_id = 1
 心血管   ci1_id = 2
 神经科   ci1_id = 3
 血液科   ci1_id = 4
 骨科     ci1_id = 5
 公益活动 ci1_id = 6
 */
//- (NSArray *)modelArray{
//    if (_modelArray == nil) {
//        
//        NSDictionary *dict = @{@"ci1_id":@1,@"":@"",@"":@"",@"":@"",@"":@"",@"":@""};
//                    
//                            
//        
//        
//        
//    }
//}

@end

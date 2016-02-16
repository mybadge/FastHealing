//
//  FHSickSimultaneousController.m
//  dcDemo
//
//  Created by ZhangZiang on 16/1/20.
//  Copyright © 2016年 ZhangZiang. All rights reserved.
//

#import "FHSickSimultaneousController.h"
#import "FHNetworkTools.h"
#import "FHSickSimultaneous.h"
#import "FHSickSimultaneousCell.h"
#import "SVProgressHUD.h"

@interface FHSickSimultaneousController ()

@property (nonatomic, strong) NSArray *selectSicks;

@property (nonatomic, strong) NSMutableArray *selectedModels;

@end

@implementation FHSickSimultaneousController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择并发症";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(enterSelected)];
//    self.tableView.separatorInset = UIEdgeInsetsMake(0,0, 0, 0);
    [self.tableView registerClass:FHSickSimultaneousCell.self forCellReuseIdentifier:@"SimultaneousCell"];
    
    [self postNetwork];
}

- (void)enterSelected {
    
    if (self.selectedModels.count > 0) {
        [self.navigationController popViewControllerAnimated:YES];
        
        if (self.blockSelected) {
            self.blockSelected(self.selectedModels);
        }
    } else {
        [SVProgressHUD showInfoWithStatus:@"请选择并发症"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view 数据源和代理方法


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.selectSicks.count;
}


- (FHSickSimultaneousCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FHSickSimultaneousCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SimultaneousCell" forIndexPath:indexPath];
    
    cell.sickModel = self.selectSicks[indexPath.row];
    
    cell.blockSelected = ^() {
        [self tableView:tableView didSelectRowAtIndexPath:indexPath];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FHSickSimultaneous *select = self.selectSicks[indexPath.row];
    
    if (![self.selectedModels containsObject:select]) {
        [self.selectedModels addObject:select];
    }
    else {
        [self.selectedModels removeObject:select];
    }
    
    FHSickSimultaneousCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    [cell maskThisCell];
    
}

#pragma mark 懒加载
- (NSMutableArray *)selectedModels {
    if (_selectedModels == nil) {
        _selectedModels = [NSMutableArray array];
    }
    return _selectedModels;
}

#pragma mark 请求网络

- (void)postNetwork {
    FHNetworkTools *manager = [FHNetworkTools sharedNetworkTools];
    
    NSString *urlStr = @"http://iosapi.itcast.cn/complicationList.json.php";
    self.ci2_id = 3;
    NSDictionary *parameter = @{@"page":@1,@"page_size":@15,@"ci2_id":@(self.ci2_id)};
    
    [manager POST:urlStr parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        NSLog(@"%@",responseObject);
        if ([responseObject[@"code"] integerValue] == 1) {
            [SVProgressHUD showErrorWithStatus:@"网络错误请重试"];
            return ;
        }
         self.selectSicks = [FHSickSimultaneous sickSimultaneousWithResponseDict:responseObject];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [SVProgressHUD showErrorWithStatus:@"网络不稳定..."];
    }];
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

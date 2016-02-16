//
//  FHSettingsAndHelp.m
//  FastHealing
//
//  Created by xiechen on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHSettingsAndHelp.h"
#import "FHFeedBackController.h"
#import "FHInstructionsViewController.h"
#import "FHChangePwdViewController.h"
#import "FHSetingModel.h"
#import "FHUserViewModel.h"
#import "UIView+ViewController.h"
#import "FHSideMenu.h"

@interface FHSettingsAndHelp ()

@property (nonatomic,strong)NSArray *strArry;

@end

@implementation FHSettingsAndHelp

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置与帮助";
    self.tableView.tableFooterView = [[UIView alloc]init];
    //创建导航栏的左边按钮
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftBtn setImage:[UIImage imageNamed:@"nav_return"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
}

- (void)leftBtnClick{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dismissVC" object:nil userInfo:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.strArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    FHSetingModel *model = self.strArry[indexPath.row];
    
    cell.textLabel.text = model.textName;
    
    //cell的右边显示的图片
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:model.imageName]];
    imageView.bounds = CGRectMake(0, 0, 30, 30);
    cell.accessoryView = imageView;
    
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

//点击cell会调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //意见反馈
    FHFeedBackController *feedBackVC = [[FHFeedBackController alloc]init];
    //加号服务说明
    FHInstructionsViewController *instructionsiVC = [[FHInstructionsViewController alloc]init];
    //修改密码
    FHChangePwdViewController *changgePwd = [[FHChangePwdViewController alloc]init];
    
    switch ((int)indexPath.row) {
        case 0:
            [self.navigationController pushViewController:feedBackVC animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:instructionsiVC animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:changgePwd animated:YES];
            break;
            
        case 3:{
            [FHUserViewModel shareUserModel].user = nil;
            FHSideMenu *sideMenu = [tableView getResponserClass:[FHSideMenu class]];
            [sideMenu showContentControllerWithVC:FHLoginVC];
            break;
        }
            
        default:
            break;
    }
}
//懒加载现实cell的数组
-(NSArray *)strArry{
    if (!_strArry) {
        _strArry = [FHSetingModel settingAndHelp];
    }
    return _strArry;
}
@end
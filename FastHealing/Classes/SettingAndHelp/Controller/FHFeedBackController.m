//
//  FHFeedBackController.m
//  FastHealing
//
//  Created by xiechen on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//
#define cellNumber 2
#define cellRowHeight 44
#define cellRowHeightFirst 0.1
#define myScreen [UIScreen mainScreen].bounds.size
#import "FHFeedBackController.h"
#import "FHSttingFeedBackModel.h"
#import "FHHeaderView.h"

@interface FHFeedBackController ()

@property (nonatomic,strong)NSArray *arr;


@end

@implementation FHFeedBackController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"意见反馈";

    
    //设置分组
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    
    self.tableView.scrollEnabled =NO;
    
    
}

- (void)barbtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

//设置分组的的组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //分组数 也就是section数
    return cellNumber;
}

//设置每组有几行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *ID = @"settingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        return cell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    FHSttingFeedBackModel *model = self.arr[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"        %@",model.textName];
    
    UIImage *image1 = [UIImage imageNamed:model.accessImageName];
    UIImageView *imageView1 = [[UIImageView alloc]initWithImage:image1];
    imageView1.frame = CGRectMake(0, myScreen.width - 40, 30, 30);
    cell.accessoryView = imageView1;
    
    UIImage *image = [UIImage imageNamed:model.imageName];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.frame = CGRectMake(5, 5, 30, 30);
    [cell.contentView addSubview:imageView];

    return cell;
}

//点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"400-633-1113" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://400-633-1113"]];
        }];
        
        [alert addAction:action1];
        [alert addAction:action2];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    if (indexPath.row == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mqq://"]];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return @"欢迎联系我们";
    }
    return @"";
}
//headerView的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        CGFloat h = myScreen.height / 2 -50;
        return h;
    }
    return cellRowHeightFirst;
}
//headerView的视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        FHHeaderView *headerView = [FHHeaderView headerView];
        headerView.didClickBlock = ^() {
            [self barbtnClick];
        };
        return headerView;
    }
    return [[UIView alloc]init];
}
//cell的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return cellRowHeightFirst;
    }
    return cellRowHeight;
}
//拖动的时候调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

//懒加载
-(NSArray *)arr{
    if (!_arr) {
        _arr = [FHSttingFeedBackModel sttingFeedBack];
    }
    return _arr;
}

@end

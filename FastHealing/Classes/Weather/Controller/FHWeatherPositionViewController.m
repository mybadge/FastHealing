//
//  FHWeatherPositionViewController.m
//  FastHealing
//
//  Created by 赫腾飞 on 16/1/21.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHWeatherPositionViewController.h"

#import "MJExtension.h"

@interface FHWeatherPositionViewController ()

@end

@implementation FHWeatherPositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.positions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuseIdentifier = @"positionCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    }
    //根据数据获取数组中的某一类型数据
    NSObject *member = self.positions[indexPath.row];
    
    if ([member isKindOfClass:[NSDictionary class]]) {
        
       NSDictionary *dict = (NSDictionary *)member;
        cell.textLabel.text = dict.allKeys.firstObject;
    }else{
        //是字符串的话
        NSString *city = (NSString *)member;
        cell.textLabel.text = city;
        //cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //根据数据获取数组中的某一类型数据
    NSObject *member = self.positions[indexPath.row];
    
    if ([member isKindOfClass:[NSDictionary class]]) {
        
        //继续push控制器
        NSDictionary *dict = (NSDictionary *)member;
        
        FHWeatherPositionViewController *vc = [[FHWeatherPositionViewController alloc] init];
        //根据key获取Value 数组）
        vc.positions = dict[dict.allKeys.firstObject];
        
        vc.title = dict.allKeys.firstObject;
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }else{
        //是字符串的话
        NSString *city = (NSString *)member;
        //1.push到主控制器
        [self.navigationController popToViewController:self.navigationController.childViewControllers.firstObject animated:YES];
        //通知
        [FHNotificationCenter postNotificationName:@"setPosition" object:city];
    }
    
}

- (NSArray *)positions{
    
    if (_positions == nil) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil];
        
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        
        return arr;
    }
    return _positions;
}

- (void)setPositionsWithArray:(NSArray *)array{
    
    self.positions = nil;
    self.positions = array;

}


@end

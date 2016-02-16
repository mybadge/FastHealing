//
//  CZMessageCell.h
//  qq01数据加载
//
//  Created by tao on 15/10/10.
//  Copyright (c) 2015年 tao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CZMessageFrame;
@interface CZMessageCell : UITableViewCell
//有一个frame 模型(frame模型里面有数据模型)
@property (strong, nonatomic) CZMessageFrame *messageFrame;

//有一个快速创建方法(在里面实现cell 的重用及 cell 的初始化 ,初始化要重写cell 的set方法在里面封装空间的创建

// 里面传UIImageView 原因是要调用tableView里面的重用方法
+ (instancetype)messageCellWithTableView:(UITableView *)tableView;


@end

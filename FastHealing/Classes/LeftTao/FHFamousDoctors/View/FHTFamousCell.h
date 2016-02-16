//
//  FHTFamousCell.h
//  FastHealing
//
//  Created by tao on 16/1/21.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  FHFamousModel;

@interface FHTFamousCell : UITableViewCell

//提供一个加载数据cell的方法
+ (instancetype)famousCellWith:(UITableView *)tableView;

//设置模型属性

@property (strong, nonatomic) FHFamousModel *famousModel;

@end

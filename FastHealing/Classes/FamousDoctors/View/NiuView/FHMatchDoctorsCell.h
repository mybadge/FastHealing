//
//  FHMatchDoctorsCell.h
//  FastHealing
//
//  Created by xianbinniu on 16/1/21.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHDoctorInfoModel.h"
@interface FHMatchDoctorsCell : UITableViewCell
//快速创建cell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
//医生信息模型
@property(nonatomic,strong) FHDoctorInfoModel *DoctorInfoModel;
@end

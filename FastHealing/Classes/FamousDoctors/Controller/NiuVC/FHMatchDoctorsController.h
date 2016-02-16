//
//  FHMatchDoctorsController.h
//  FastHealing
//
//  Created by xianbinniu on 16/1/21.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FHMatchDoctorsController : UITableViewController

//参数字典
@property(nonatomic,strong) NSDictionary *paramDict;
//参数字典(传递用户疾病的信息)
@property(nonatomic,strong) NSDictionary *RealSickTypeDict;

@end

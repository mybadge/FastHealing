//
//  FHChooseDiseasePopController.h
//  FastHealing
//
//  Created by 王 on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FHDiseaseModel,FHChooseDiseasePopController;
@protocol chooseDiseasePopDelegate <NSObject>

- (void)chooseDiseasePopController:(FHChooseDiseasePopController *)popVC diseaseTitle:(NSString *)title andDiseaseName:(NSString *)diseaseName;

@end
@interface FHChooseDiseasePopController : UITableViewController

@property (strong, nonatomic) FHDiseaseModel *disease;

//创建代理
@property (weak, nonatomic) id<chooseDiseasePopDelegate> delegate;

@end

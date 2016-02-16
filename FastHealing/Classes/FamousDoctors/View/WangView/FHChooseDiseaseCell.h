//
//  FHChooseDiseaseCell.h
//  FastHealing
//
//  Created by 王 on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHDiseaseModel.h"

@class FHChooseDiseaseCell;
@protocol chooseDiseaseCellDelegate <NSObject>

- (void)chooseDisease:(FHChooseDiseaseCell *)cell;

@end

@interface FHChooseDiseaseCell : UICollectionViewCell

@property (strong, nonatomic) FHDiseaseModel *disease;
//设置代理
@property (weak, nonatomic) id<chooseDiseaseCellDelegate> delegate;

@end

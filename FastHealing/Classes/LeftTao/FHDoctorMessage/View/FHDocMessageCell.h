//
//  FHDocMessageCell.h
//  FastHealing
//
//  Created by tao on 16/1/22.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  FHDoctorMessageModel;
@class FHRequireModel;
@interface FHDocMessageCell : UICollectionViewCell


/**
 提供一个数据模型
 */

@property (strong, nonatomic) FHDoctorMessageModel *messageModel;


//医生描述模型
@property (strong, nonatomic) FHRequireModel *requireModel;

+ (instancetype)loadDocMessageCellWith:(UICollectionView *)collectionView;




@end

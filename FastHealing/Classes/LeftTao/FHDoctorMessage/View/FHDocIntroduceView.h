//
//  FHDocIntroduceView.h
//  FastHealing
//
//  Created by tao on 16/1/22.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FHDoctorMessageModel;
@class FHRequireModel;
@interface FHDocIntroduceView : UIView

//模型
@property (strong, nonatomic) UICollectionView *collectionView;

//医生描述模型
@property (strong, nonatomic) FHDoctorMessageModel *messageModel;

/**
 *  就诊条件模型
 */
@property (strong, nonatomic) FHRequireModel *requireModel;


//+ (instancetype)loadIntroDuctView;

@end

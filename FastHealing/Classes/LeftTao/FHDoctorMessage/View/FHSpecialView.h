//
//  FHSpecialView.h
//  FastHealing
//
//  Created by tao on 16/1/23.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <UIKit/UIKit.h>


@class FHDoctorMessageModel;
@class FHRequireModel;



@interface FHSpecialView : UIView


+ (instancetype)loadSpecialView;


//医生描述模型
@property (strong, nonatomic) FHDoctorMessageModel *messageModel;

/**
 *  就诊条件模型
 */
@property (strong, nonatomic) FHRequireModel *requireModel;


@end

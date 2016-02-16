//
//  FHDoctorMessage.h
//  FastHealing
//
//  Created by tao on 16/1/22.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHRequireModel.h"
@class FHMyCollectionModel;
@class FHDoctorMessageModel;

typedef void(^SendMessageBlock)(UIViewController *tableVC);

@interface FHDoctorMessage : UIView

/**
 *  医生基本信息模型
 */
@property (strong, nonatomic) FHMyCollectionModel *collectionDocModel;
/**
 医生描述模型
 */

@property (strong, nonatomic) FHDoctorMessageModel *docMessageModel;

/**
 *   医生接诊条件模型
 */
@property (strong, nonatomic) FHRequireModel *requireModel;
/**
 *  发消息block
 */
@property (copy, nonatomic) SendMessageBlock sendMessageBlock;

+ (instancetype)loadDoctorMessage;




@end

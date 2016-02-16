//
//  FHRequireModel.h
//  FastHealing
//
//  Created by tao on 16/1/24.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FHRequireModel : NSObject

/**
 *  str:{"msg":"OK","data":{"receiving_setting_extra":"特殊条件特殊条件特殊条件特殊条件特殊条件特殊条件 特殊条件特殊条件特殊条件特殊条件特殊条件特殊条件特殊条件特殊条件特殊条件啊谁都发生地方","receiving_settings":["需要提供并发症","需要患者为首诊","需要提供个人史","需要提供疾病描述","需要提供病例"]},"code":0}
 */

/**
*  额外条件
*/


@property (copy, nonatomic) NSString *receiving_setting_extra;
/**
 *  普通条件数组
 */


@property (copy, nonatomic) NSArray *receiving_settings;
@end












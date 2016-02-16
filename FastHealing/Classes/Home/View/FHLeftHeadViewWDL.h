//
//  FHLeftHeadViewWDL.h
//  FastHealing
//
//  Created by 赵志丹 on 16/1/21.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BtnClickBlock)(NSString *choosePage);
@interface FHLeftHeadViewWDL : UIView
@property (nonatomic, copy) BtnClickBlock btnClickBlock;
+ (instancetype)leftHeadViewWDL;

@end

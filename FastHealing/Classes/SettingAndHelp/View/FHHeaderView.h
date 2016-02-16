//
//  FHHeaderView.h
//  FastHealing
//
//  Created by xiechen on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^DidClickBlock)();
@interface FHHeaderView : UIView
@property (nonatomic, copy) DidClickBlock didClickBlock;
+ (instancetype)headerView;

@end

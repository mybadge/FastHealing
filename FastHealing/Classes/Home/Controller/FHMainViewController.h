//
//  FHMainViewController.h
//  FastHealingD
//
//  Created by 赵志丹 on 16/1/19.
//  Copyright © 2016年 FastHeading. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 回到主页 */
typedef void (^BackMainVcBlock)();
@interface FHMainViewController : UIViewController
/** 回到主页 */
@property (nonatomic, copy) BackMainVcBlock backMainVcBlock;
/** 是否已经打开了左边菜单 */
@property (nonatomic, assign) BOOL isOpenLeft;
@end

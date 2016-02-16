//
//  FHSickDetailController.h
//  dcDemo
//
//  Created by ZhangZiang on 16/1/20.
//  Copyright © 2016年 ZhangZiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHDetailSick.h"

@interface FHSickDetailController : UIViewController

@property (nonatomic, assign) NSInteger ci1_id;

@property (nonatomic, copy) void (^blockSelected)(FHDetailSick *sick);

@end

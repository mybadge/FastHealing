//
//  FHSickSimultaneousController.h
//  dcDemo
//
//  Created by ZhangZiang on 16/1/20.
//  Copyright © 2016年 ZhangZiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FHSickSimultaneousController : UITableViewController

@property (nonatomic, assign) NSInteger ci2_id;

@property (nonatomic, copy) void (^blockSelected) (NSArray *);

@end

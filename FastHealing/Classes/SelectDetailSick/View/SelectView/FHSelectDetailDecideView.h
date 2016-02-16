//
//  FHSelectDetailDecideView.h
//  FastHealing
//
//  Created by ZhangZiang on 16/1/21.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FHSelectDetailDecideView : UIView

@property (nonatomic, copy) void (^blockClicked)();

@property (nonatomic, assign) NSInteger doctorNum;

@property (nonatomic, assign) NSInteger treatMethod;
@property (nonatomic, assign) BOOL hasTreatMethod;

@end

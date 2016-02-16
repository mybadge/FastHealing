//
//  CZMessageFrame.h
//  qq01数据加载
//
//  Created by tao on 15/10/10.
//  Copyright (c) 2015年 tao. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CZTextFont [UIFont systemFontOfSize:17]
@class  CZMessage;

@interface CZMessageFrame : NSObject
//空间frame的属性
//@property (nonatomic, assign, readonly) CGRect <#iconF#>;

@property (nonatomic, assign, readonly) CGRect textButtonF;
@property (nonatomic, assign, readonly) CGRect iconImageViewF;
@property (nonatomic, assign, readonly) CGRect timerLabelF;
@property (nonatomic, assign, readonly) CGFloat cellHeight;



// 数据
@property (strong, nonatomic) CZMessage *message;

@end

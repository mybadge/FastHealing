//
//  CZMessage.h
//  qq01数据加载
//
//  Created by tao on 15/10/10.
//  Copyright (c) 2015年 tao. All rights reserved.
//
typedef enum{
    CZMessageTypeOther = 0,
    CZMessageTypeMe = 1
}CZMessageType;
#import <Foundation/Foundation.h>

@interface CZMessage : NSObject
//neirong
@property (copy, nonatomic) NSString *text;
// 时间
@property (copy, nonatomic) NSString *time;
//枚举表示是谁发的消息
@property (assign, nonatomic) CZMessageType type;
@property (nonatomic, assign, getter=isHidden) BOOL  isHidden;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)messageWithDict:(NSDictionary *)dict;


@end

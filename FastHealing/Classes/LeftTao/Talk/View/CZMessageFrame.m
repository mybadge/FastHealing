//
//  CZMessageFrame.m
//  qq01数据加载
//
//  Created by tao on 15/10/10.
//  Copyright (c) 2015年 tao. All rights reserved.
//

#import "CZMessageFrame.h"
#import "CZMessage.h"

@implementation CZMessageFrame
//冲写数据模型的set方法,在里面封装空间frame的计算
- (void)setMessage:(CZMessage *)message{
//#warning CZMessage 该写这里了
    _message = message;
   // NSLog(@"jjjjjj%d",_message.isHidden);
    CGFloat margin = 10;
    //去屏幕的宽
    CGFloat screenW = [UIScreen  mainScreen].bounds.size.width;
    //1.时间文本
    if (_message.isHidden == NO) {
        CGFloat timeX = 0;
        CGFloat timeY = 0;
        CGFloat timeW = screenW;
        CGFloat timeH = 25;
         _timerLabelF = CGRectMake(timeX, timeY, timeW, timeH);
    }
    
   
    //2.头像
    CGFloat iconY = CGRectGetMaxY(_timerLabelF) + margin;
    CGFloat iconW = 50;
    CGFloat iconH = iconW;
    //要判断如果是自己的头像
    CGFloat iconX = message.type ? (screenW - margin - iconW)      : margin;
    _iconImageViewF = CGRectMake(iconX, iconY, iconW, iconH);
    
    //3.聊天内容
    //在这里要计算文字的高
    //1.设置文本最大宽和高
    CGSize textMax = CGSizeMake(200, MAXFLOAT);
    //把字体包成一个字典
    NSDictionary *arrt = @{NSFontAttributeName : CZTextFont};
    CGSize textSize = [message.text boundingRectWithSize:textMax options:NSStringDrawingUsesLineFragmentOrigin attributes:arrt context:nil].size;
    //计算y
    CGFloat textY = iconY + margin;
    //计算X要分类,分自己的和别人的
    //别人的X  = iconX + margin
    //自己的X = iconX - maigin - 文字的计算宽度
    CGFloat textX = message.type ? (iconX - margin - textSize.width - 40) : (CGRectGetMaxX(_iconImageViewF) + margin);
    _textButtonF = CGRectMake(textX, textY, textSize.width + 40, textSize.height + 40 );
    
    //4.计算行高
    //行高等于头象或者是聊天内容最大Y + magin
    _cellHeight = MAX(CGRectGetMaxY(_iconImageViewF), CGRectGetMaxY(_textButtonF)) + margin;
    //NSLog(@"%ld",_cellHeight);
    
    
    
}

@end









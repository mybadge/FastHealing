//
//  CZMessageCell.m
//  qq01数据加载
//
//  Created by tao on 15/10/10.
//  Copyright (c) 2015年 tao. All rights reserved.
//


#pragma mark--Cell模型
#import "CZMessageCell.h"
#import "CZMessageFrame.h"
#import "CZMessage.h"
//
@interface CZMessageCell()
//在里面设施属性
//时间
@property (weak, nonatomic) UILabel *timerLabel;
//内容
@property (weak, nonatomic) UIButton *textButton;
//头像
@property (weak, nonatomic) UIImageView *iconImageView;
@end


@implementation CZMessageCell
#pragma mark--CZMessageCell 的快速创建,里面封装有空间的初始化
+ (instancetype)messageCellWithTableView:(UITableView *)tableView{
    //1.设置重用表示
    static NSString *ID = @"message";
    //2.调用缓存池中的cell
    CZMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        // 创建
        cell = [[CZMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    //cell.preservesSuperviewLayoutMargins = NO;
    //tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
   // NSLog(@"lllllllllll%@",NSStringFromCGRect(cell.bounds));
    return cell;
}

//重写CZMessageCell的初始化方法,在里面封装空间初始化方法
#pragma mark---重写CZMessageCell的初始化方法,
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //初始化空间
        //1.时间文本
        UILabel *timeLabel = [[UILabel alloc]init];
        [self.contentView addSubview:timeLabel];
        //让文字居中
        timeLabel.textAlignment = NSTextAlignmentCenter;
        //字体大小
        timeLabel.font = [UIFont  systemFontOfSize:15];
        //文本字体颜色
        timeLabel.textColor = [UIColor grayColor];
        
        self.timerLabel = timeLabel;
        //2.头像
        UIImageView *iconImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconImageView];
        self.iconImageView = iconImageView;
        //3.聊天内容
        UIButton *textButton = [[UIButton alloc]init];
        //textButton.backgroundColor = [UIColor redColor];
        //设置文字大小
        textButton.titleLabel.font = CZTextFont;
        //设置换行
        textButton.titleLabel.numberOfLines = 0;
        //设置文本的内边距
        textButton.contentEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
        //textButton.titleLabel.textAlignment = 0;
        [self.contentView addSubview:textButton];
        self.textButton = textButton;
        
    }
    //清空cell的背景颜色(防止它遮盖tableView的颜色)
    self.backgroundColor = [UIColor clearColor];
    
    return self;
}

#pragma mark 重写frame的set方法
//重写CZMessageFrame的set方法,当给frame赋值的时候调用,在这里面封装控件数据设计
- (void)setMessageFrame:(CZMessageFrame *)messageFrame{
    _messageFrame = messageFrame;
    
    //1.设置控件属性
    [self setSubViewsMessage];
    //2.设置控件frame
    //[self setSubViewsFrame];
  
}

//设置控件属性
- (void)setSubViewsMessage{
    CZMessage *message = self.messageFrame.message;

    //1.时间文本
    //self.timerLabel.text = message.time;
    //为了优化性能则
    if (!message.isHidden/** 判断是否需要显示时间*/) {
        //如果显示时间就把创建的文本显示出来,并赋值
        self.timerLabel.hidden = NO;
        self.timerLabel.text = message.time;
        self.timerLabel.frame = self.messageFrame.timerLabelF;
    }else{
        //如果不显示时间就把创建的文本隐藏,
         self.timerLabel.hidden = NO;
    }
   
    //2.头像
    NSString *path  = message.type ? @"me" :  @"Other";
    self.iconImageView.image = [UIImage imageNamed:path];
    //头像frame
    self.iconImageView.frame = self.messageFrame.iconImageViewF;
    
    //3.聊天内容
    [self.textButton setTitle:message.text forState:UIControlStateNormal];
    //给聊天内容设置背景图片
    //图片分为别人发的和自己发的
    //设置图片路径
    NSString *textButtonBackGroundPath = self.messageFrame.message.type ? @"chat_send_nor" : @"chat_recive_nor" ;
    //设置聊天的被背景
    UIImage *bj = [UIImage imageNamed:textButtonBackGroundPath];
//    [self.textButton setBackgroundImage:bj forState:UIControlStateNormal];
    //设置背景图片的拉伸方式
    //1.设置要保护的范围
    CGFloat leftcap = (bj.size.width) * 0.5;
    CGFloat topcap = bj.size.height*0.5;
    //1.拉伸方法1
    //UIImage *newbj = [bj resizableImageWithCapInsets:UIEdgeInsetsMake( topcap,leftcap, topcap, leftcap)];
     //2.拉伸方法2
    //UIImage *newbj = [bj resizableImageWithCapInsets:UIEdgeInsetsMake( topcap,leftcap, topcap, leftcap) resizingMode: UIImageResizingModeStretch/**拉伸方式,平铺或拉伸*/];
     //3.拉伸方法3,已经过时
    UIImage *newbj = [bj
                      stretchableImageWithLeftCapWidth:leftcap topCapHeight:topcap];
    
    [self.textButton setBackgroundImage:newbj forState:UIControlStateNormal];
    
    //设置文字颜色
    UIColor *color = self.messageFrame.message.type ? [UIColor blackColor] : [UIColor redColor];
    
    [self.textButton setTitleColor:color forState:UIControlStateNormal];
     
    
    //聊天内容frame
    self.textButton.frame = self.messageFrame.textButtonF;
}

////设置frame
//- (void)setSubViewsFrame{
//    //1.时间文本,为了优化性能吧它放上面
//   // self.timerLabel.frame = self.messageFrame.timerLabelF;
//
//    //2.头像frame
//    self.iconImageView.frame = self.messageFrame.iconImageViewF;
//    
//    //3.聊天内容
//    self.textButton.frame = self.messageFrame.textButtonF;
//    
//}
@end










//
//  ViewController.m
//  qq01数据加载
//
//  Created by tao on 15/10/10.
//  Copyright (c) 2015年 tao. All rights reserved.
//

#import "ViewController.h"
#import "CZMessage.h"
#import "CZMessageFrame.h"
#import "CZMessageCell.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
//@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//编辑文本要进行连线
//@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) NSMutableArray *messageFrameArray;
@property (strong, nonatomic) NSDictionary *autoDictionary;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableBottom;

//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstrain;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstrain;


@end

@implementation ViewController

+ (instancetype)loadVC{
    ViewController *vc  = [[[NSBundle mainBundle] loadNibNamed:@"ViewController" owner:nil options:nil] lastObject];
    vc.title = @"与女神聊天";
    return vc;
}



- (void)awakeFromNib{
    //设置数据源
    self.tableView.dataSource = self;
    //self.tableView.rowHeight = 100;
    //设置代理tableView的
    self.tableView.delegate = self;
    //隐藏滚动条
    self.tableView.showsVerticalScrollIndicator = NO;
    //隐藏cell的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //设置tableView的背景颜色
    //里面的前三个参数为各个颜色占得比例
    self.tableView.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:190/255.0 alpha:1];
#pragma mark 监听键盘通知
    // [NSNotificationCenter defaultCenter] 获取通知中心对象
    
    //注册监听
    //[NSNotificationCenter defaultCenter] addObserver:<#(id)#>(监听对象老王) selector:<#(SEL)#>(老万受到通知后要干的事) name:<#(NSString *)#>(通知的名字@"xiaoshipin") object:<#(id)#>(法通知的对象(sina)
    
    //发布通知
    // [NSNotificationCenter defaultCenter]postNotificationName:<#(NSString *)#>(通知的名字@"xiaoshipin") object:<#(id)#> (发通知的对象sina)userInfo:<#(NSDictionary *)#>@{@"title" : @"精彩金鸡"
    
   // [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillChangFrame:) name:UIKeyboardWillChangeFrameNotification   object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardHidden:) name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    
#pragma mark 让内容滚到最后一行
    NSIndexPath *indexP = [NSIndexPath indexPathForRow:self.messageFrameArray.count - 1 inSection:0];
    //NSLog(@"aaaaaaaaaa%ld",indexPath.row);
    //NSLog(@"bbbbbbbbb%ld",indexP.row);
    [self.tableView scrollToRowAtIndexPath:indexP atScrollPosition:UITableViewScrollPositionBottom animated:YES];
#pragma 设置textField文本的 的代理了
    self.textField.delegate = self;
    //设置文本的属性
    //设置左占位
    UIImageView *leftView = [[UIImageView alloc]init];
    leftView.frame = CGRectMake(0, 0, 8, 0);
    self.textField.leftView = leftView;
    //设置后还不显示,故要进行格式设置
    self.textField.leftViewMode = UITextFieldViewModeAlways;

}


//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    //self.view
//    
//    
//}

#pragma mark self监听键盘通知后做的事情
- (void)keyBoardShow:(NSNotification *)note {
    NSValue *value =  note.userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect rect  = [value CGRectValue];
    //self.view.transform = CGAffineTransformMakeTranslation(0, -rect.size.height);
    self.bottomConstrain.constant = rect.size.height;
   // self.tableBottom.constant = 0;
   
    [UIView animateWithDuration:0.25 animations:^{
        [self.view.layer layoutIfNeeded];
        //[self.tableView reloadData];
      
    }];
    NSIndexPath *indexP = [NSIndexPath indexPathForRow:(self.messageFrameArray.count - 1 )inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexP atScrollPosition:UITableViewScrollPositionBottom animated:YES];
     //[self sendMessageWithText:@"你好" messageType:1];
}



//keyBoardHidden
- (void)keyBoardHidden:(NSNotification *)note {
     //self.tableBottom.constant = 0;
    self.bottomConstrain.constant = 0;
    //[self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messageFrameArray.count inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    [UIView animateWithDuration:0.25 animations:^{
        [self.view.layer layoutIfNeeded];
    }];
    
}

#pragma mark   当拖拽时把键盘隐藏
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    
    self.bottomConstrain.constant = 0;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view.layer layoutIfNeeded];
    }];
    //当开始拖拽式view结束编辑
    [self.view endEditing:YES];
}
//当控制器销毁时把控制器在通知中心注册的通知销毁
- (void)dealloc{
    //把监听对象移除
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark  数据源
//返回有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   // NSLog(@"%ld",self.messageFrameArray.count);
    return self.messageFrameArray.count;
}
// 每行的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //1.创建cell
    CZMessageCell *cell = [CZMessageCell messageCellWithTableView:tableView];
    //NSLog(@"qqqqqqqqqq%@",NSStringFromCGRect(cell.bounds));
    //2.给sell赋值
    //取出模型数据
    CZMessageFrame *messageModel = self.messageFrameArray[indexPath.row];
    //NSLog(@"mmmmmmmm%@",NSStringFromCGRect(cell.bounds));
    cell.messageFrame = messageModel;
    //NSLog(@"%f",cell.messageFrame.cellHeight);
//    //3.返回cell
    
    //NSLog(@"ooooooo%@",NSStringFromCGRect(cell.bounds));
    //NSLog(@"%ld",indexPath.row);
    return cell;
}
#pragma mark 代理实现返回行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //取出模型数据
    CZMessageFrame *frameModel = self.messageFrameArray[indexPath.row];
    // NSLog(@"%f",frameModel.cellHeight);
    return frameModel.cellHeight;
}

//实现自动回复
#pragma mark 自动回复
#pragma mark 根据输入文本内容返回自动回复的内容
- (NSString *)autoRestore:(NSString *)text{
    //消息文字
    //NSRange
    for (int i = 0; i < text.length ; i++) {
        //把消息的字符串拆解
        NSString *sendWord = [text substringWithRange:NSMakeRange(i, 1)];
        if (self.autoDictionary[sendWord]) {
            //如果这个键存在就把值返回
            return _autoDictionary[sendWord];
        }
    }
    //如果没有该键就返回88
    return @"88";
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
  
    //1.获得文本文字
    NSString *inPutText = textField.text;
    //2.根据文字获得自动回复的文字
   NSString *answer =  [self autoRestore:inPutText];
    NSLog(@"%@",answer);
    
    //3.把他们都加到数组中
    //自己发的消息
    [self sendMessageWithText:inPutText messageType:CZMessageTypeMe];
    //回复的消息
    [self sendMessageWithText:answer messageType:CZMessageTypeOther];
    //清空文本框
    textField.text = nil;
    return YES;
}

#pragma mark 根据发过来的字,和是谁发的把他们添加到字典,并刷新数据
- (void)sendMessageWithText:(NSString *)text messageType:(CZMessageType)messageType{
    //1. 创建模型
    CZMessage *newMessage = [[CZMessage alloc]init];
    //2.设只里面的属性
    //设置内容
    newMessage.text = text;
    //设置是谁发的
    newMessage.type = messageType;
    //设置时间
    //获得系统时间
    NSDate *newData = [NSDate date];
    //创建时间格式化对象
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc]init];
    //指定时间格式
    //timeFormat.dateFormat = @"yyyy-MM-dd HH-mm-ss";
    timeFormat.dateFormat = @"HH-mm";
    //把时间对象以指定格式转化为字符串
    NSString *newTime = [timeFormat stringFromDate:newData];
    //赋值
    newMessage.time = newTime;
    
    //判断是否需要显示时间
    //创建frame模型
    CZMessageFrame *newMessageFrame = [[CZMessageFrame alloc]init];
    //取上一个时间
    CZMessageFrame *lastFrame = [self.messageFrameArray lastObject];
    NSString *lastTime = lastFrame.message.time;
    //判断俩个时间是否相等
    newMessage.isHidden = [lastTime isEqualToString:newTime];
    //把创建号的数据赋值给心的frame并添加到数组
    newMessageFrame.message = newMessage;
    [self.messageFrameArray addObject:newMessageFrame];
    
    //刷新数据
    [self.tableView reloadData];
    //滚动到最后一行
    NSIndexPath *indexP = [NSIndexPath indexPathForRow:(self.messageFrameArray.count - 1 )inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexP atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    
}


// 隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}
#pragma mark 懒加载
- (NSMutableArray *)messageFrameArray{
    if (_messageFrameArray == nil) {
        //把plist问及在哪转化为数组
        //NSLog(@"mmmzoulemeimmm");
        NSArray *messagePlist = [[NSArray alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"messages.plist" ofType:nil]];
        //NSLog(@"%ld",messagePlist.count);
        //创建可变数组
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:messagePlist.count];
        //遍历转模型
        for (NSDictionary *dict  in messagePlist) {
        
            
            CZMessageFrame *messageFrame =  [[CZMessageFrame alloc]init];
#pragma mark 添加是否隐藏时间文本属性
            CZMessage *messageModel = [CZMessage messageWithDict:dict];
            //取出新时间
            NSString *newTime = messageModel.time;
            //新建frame
            CZMessageFrame *oldFrame = [arrM lastObject];
           messageModel.isHidden = [(oldFrame.message.time) isEqualToString : newTime];
            //NSLog(@"zaaahuishi%d", messageModel.isHidden);
            //给frame里面的message赋值
            
            messageFrame.message = messageModel;
            [arrM addObject:messageFrame];
        }
        _messageFrameArray= arrM;
    }
    return _messageFrameArray;
}

#pragma 自动回复懒加载
- (NSDictionary *)autoDictionary{
    if (_autoDictionary == nil) {
        _autoDictionary = [[NSDictionary alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"autoRestore.plist" ofType:nil]];
    }
    return _autoDictionary;
}
@end












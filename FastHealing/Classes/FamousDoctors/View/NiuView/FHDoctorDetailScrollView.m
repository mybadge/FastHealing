//
//  FHDoctorDetailScrollView.m
//  FastHealing
//
//  Created by xianbinniu on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHDoctorDetailScrollView.h"
#import "SVProgressHUD.h"
#import "FHDoctorRecView.h"
#import "Masonry.h"

@interface FHDoctorDetailScrollView ()<UIWebViewDelegate>
{  //保存日期中第几天,对应表格的行列数
    int dutyNum[7];
}

@property(nonatomic,weak)UIWebView *web3;
@property(nonatomic,weak)FHDoctorRecView *RecView;
@property(nonatomic,weak)UILabel *intro;
@property(nonatomic,weak)UIScrollView *introView;

//记录属性
@property(nonatomic,copy)NSString *zuozhen_fee;
@property(nonatomic,copy)NSString *zuozhen_hospital_name;
@property(nonatomic,copy)NSString *duty_date;
@property(nonatomic,copy)NSString *start_date;

@property(nonatomic,strong)NSMutableArray *listData;

@property(nonatomic,assign)NSInteger  index;

@end

@implementation FHDoctorDetailScrollView

-(void)awakeFromNib{
    //数组初始化
    for (int i=0; i<7;i++) {
        dutyNum[i]=31;
    }
    self.index=0;
    //设置属性
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.pagingEnabled = YES;
    self.alwaysBounceVertical = NO;
    self.alwaysBounceHorizontal = YES;
    self.bounces=NO;
    
    FHDoctorRecView *RecView=[[FHDoctorRecView alloc]init];
    self.RecView=RecView;
    [self addSubview:RecView];
    
    UIScrollView *introView=[[UIScrollView alloc]init];
    introView.backgroundColor=[UIColor whiteColor];
    [self addSubview:introView];
    self.introView=introView;
    UILabel *lable=[[UILabel alloc]init];
    [introView addSubview:lable];
    self.intro=lable;
    lable.numberOfLines=0;

    UIWebView *web3 = [[UIWebView alloc]init];
    web3.backgroundColor= [UIColor whiteColor];
     self.web3 = web3;
    [self addSubview:web3];
    
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    NSLog(@"%@",request.URL.absoluteString);
    //由ID判断是否需要跳转绑定身份证页面
    NSString *ID=[[NSUserDefaults standardUserDefaults] objectForKey:NUserRealID];
    //跳转(身份绑定之后)
    NSString *str=request.URL.absoluteString;
    
    str=[str substringFromIndex:str.length-2];
    
    if ([self.listData containsObject:str]&&ID!=nil) {
            NSLog(@"%@",request.URL.absoluteString);
        NSString *str=request.URL.absoluteString;
        str=[str substringFromIndex:6];
        int index=[str intValue];
        NSLog(@"%d",index);
        NSArray *weekArr=@[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
        NSArray *dayTime=@[@"上午",@"下午",@"晚上"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"case" object:nil userInfo:@{@"week":weekArr[index%10-1],@"dayTime":dayTime[index/10-1]}];
        return NO;
    }
    if (self.index!=0) {
     
        if (ID==nil) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"niu" object:nil];
        }
    }
    self.index++;
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    if (self.start_date!=nil) {
        //日期转换
        NSString *str1=[self.start_date substringWithRange:NSMakeRange(5, 2)];
        int num1=[str1 intValue];
        NSString *str2=[self.start_date substringWithRange:NSMakeRange(8, 2)];
        int num2=[str2 intValue];
        NSString *str3 = [NSString stringWithFormat:@"myFunction000(%d,%d)",num1,num2];
        [self.web3 stringByEvaluatingJavaScriptFromString:str3];
    }
    if (self.zuozhen_hospital_name!=nil) {
        NSString *str1 = [NSString stringWithFormat:@"myFunction111('%@');",self.zuozhen_hospital_name];
     str1 = [self.web3 stringByEvaluatingJavaScriptFromString:str1];
//        NSLog(@"%@",str1);
    }
    if (self.zuozhen_fee!=nil) {
        NSString *str1 = [NSString stringWithFormat:@"myFunction112('%@');",self.zuozhen_fee];
        [self.web3 stringByEvaluatingJavaScriptFromString:str1];
    }
    for (int i=0; i<7; i++) {
    
            NSString *str1 = [NSString stringWithFormat:@"myFunction001(%d);",dutyNum[i]];
            [self.web3 stringByEvaluatingJavaScriptFromString:str1];
 
    }
    
//    //清除cookies
//    NSHTTPCookie *cookie;
//    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    for (cookie in [storage cookies])
//    {
//        [storage deleteCookie:cookie];
//    }
//    //清除缓存
//    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}
-(void)setContentIntorStr:(NSString *)contentIntorStr{
    _contentIntorStr=contentIntorStr;
    self.intro.text=contentIntorStr;
    //计算大小
    CGSize size= [contentIntorStr boundingRectWithSize:CGSizeMake(FHScreenSize.width-15, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    self.intro.font=[UIFont systemFontOfSize:15];
    self.intro.textColor=[UIColor lightGrayColor];
    self.intro.frame=CGRectMake(7.5, 10, size.width, size.height);
    self.introView.contentSize = CGSizeMake(FHScreenSize.width, size.height+13);
}

-(void)setDoctorRecTimeModel:(FHDoctorRecTimeModel *)DoctorRecTimeModel{
    _DoctorRecTimeModel=DoctorRecTimeModel;
    self.start_date=DoctorRecTimeModel.start_date;

    for (FHDoctorFeeModel *fee in DoctorRecTimeModel.zuozhen_infos) {
        self.zuozhen_fee=fee.zuozhen_fee;
        self.zuozhen_hospital_name=fee.zuozhen_hospital_name;
        
    }
    int i=0;
    for (FHDoctorDutyModel *Model in DoctorRecTimeModel.duties) {
//        NSLog(@"%@--%@",Model.duty_date,Model.duty_status_name);
        //日期转换
       
        NSString *str2=[Model.duty_date substringWithRange:NSMakeRange(8, 2)];
        int num2=[str2 intValue];
        num2=num2%30;
        dutyNum[i]=num2;
        i++;
        NSString *formatStr=[NSString stringWithFormat:@"1%d",num2];
        [self.listData addObject:formatStr];
    }
    
    NSURLRequest *req = [[NSURLRequest alloc]initWithURL:[self LocalHTMLPath:@"table"]];
    [_web3 loadRequest:req];
    self.web3.delegate=self;
}
-(void)setArrM:(NSArray *)ArrM{
    _ArrM=ArrM;
    self.RecView.ArrM=ArrM;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.RecView.frame = CGRectMake(0, 0, FHScreenSize.width, self.frame.size.height);
    self.introView.frame = CGRectMake(FHScreenSize.width*1, 0, FHScreenSize.width, self.frame.size.height);
    self.web3.frame = CGRectMake(FHScreenSize.width*2, 0, FHScreenSize.width, self.frame.size.height);
    self.contentSize = CGSizeMake(FHScreenSize.width*3, self.frame.size.height);

}
//本地HTML文件
-(NSURL *)LocalHTMLPath:(NSString *)name{
    NSString *path = [[NSBundle mainBundle]pathForResource:name ofType:@"html"];
    return [NSURL fileURLWithPath:path];
}
-(NSMutableArray *)listData{
    if (_listData==nil) {
        _listData=[NSMutableArray array];
    }
    return _listData;
}
@end

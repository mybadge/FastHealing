//
//  FHCaseManageVC.m
//  FastHealing
//
//  Created by tao on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHCaseManageVC.h"
#import "Masonry.h"
#import "SVProgressHUD.h"
//#import "FHPagerWebViewController.h"
#import "FHBaiController.h"
#import "FHNavigationController.h"
#import "AFNetworking.h"
#import "FHCaseFloderController.h"
@interface FHCaseManageVC ()<UITextFieldDelegate>
@property (copy, nonatomic) NSString *name;
@property (strong, nonatomic) UITextField *nameText;
@property (strong, nonatomic) UITextField *IDText;
@property (copy, nonatomic) NSString *IDStr;
@property(nonatomic, strong) AFHTTPSessionManager *sessionManager;
@end

@implementation FHCaseManageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //设置导航栏
    [self setNav];
    //设置界面
    [self setupUI];
    
}

//设置界面
- (void)setupUI{
    //1.创建名字
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.text = @"真实姓名 :";
    //nameLabel.frame = CGRectMake(0, 100, 100, 100);
    nameLabel.font = [UIFont systemFontOfSize:17];
    //添加到付控件
    [self.view addSubview:nameLabel];
    [nameLabel sizeToFit];
    //设置布局
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(104);
        make.left.equalTo(self.view.mas_left).offset(20);
        
    }];
    //1.1创建姓名输入框
    UITextField *nameText = [[UITextField alloc]init];
    //设置一下输入框的样式
    nameText.borderStyle = UITextBorderStyleRoundedRect;
    nameText.font = [UIFont systemFontOfSize:17];
    nameText.placeholder = @"请输入真实姓名";
    [self.view addSubview:nameText];
    nameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    //监听tentField
    //nameText.delegate = self;
    [nameText addTarget:self action:@selector(nameTextChange) forControlEvents:UIControlEventEditingChanged];
    
    
    [nameText mas_makeConstraints:^(MASConstraintMaker *make) {
        
   make.left.equalTo(self.view.mas_left).offset(20+nameLabel.width+10);
        
        //make.left.equalTo(nameLabel.mas_right).offset(10);
        make.centerY.equalTo(nameLabel.mas_centerY);
        make.right.equalTo(self.view.mas_right).offset(-20);
       
    }];
    self.nameText = nameText;
    //2.创建身份证label
    UILabel *IDLabel = [[UILabel alloc]init];
    IDLabel.text = @"身份证号 :";
    IDLabel.font = [UIFont systemFontOfSize:17];
    //添加到父控件
    [self.view addSubview:IDLabel];
    //设置布局
    [IDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.top.equalTo(nameLabel.mas_bottom).offset(40);
    }];
    
    //2.1创建身份证输入框
    UITextField *IDText = [[UITextField alloc]init];
    //设置一下输入框的样式
    IDText.borderStyle = UITextBorderStyleRoundedRect;
    IDText.font = [UIFont systemFontOfSize:17];
    IDText.placeholder = @"请输入真实身份证";
    [self.view addSubview:IDText];
    
    IDText.clearButtonMode = UITextFieldViewModeWhileEditing;
    //监听tentField
    //nameText.delegate = self;
    [IDText addTarget:self action:@selector(IDTextChange) forControlEvents:UIControlEventEditingChanged];
    
    [IDText mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.left.equalTo(self.view.mas_left).offset(10);
        make.left.equalTo(IDLabel.mas_right).offset(10);
        make.centerY.equalTo(IDLabel.mas_centerY);
        make.right.equalTo(self.view.mas_right).offset(-20);
    }];
    //给全局属性赋值
    self.IDText = IDText;
    //3.添加UIImage
    UIImageView *alertImageView = [[UIImageView alloc]init];
   
    [self.view addSubview:alertImageView];
    
    [alertImageView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.width.offset(20);
        make.height.offset(20);
        make.top.equalTo(IDLabel.mas_bottom).offset(40);
        make.left.equalTo(self.view.mas_left).offset(20);
    }];
  
    alertImageView.image = [UIImage imageNamed:@"02.png"];
    
    //4.创建提示文本
    UILabel *alertLabel =[[UILabel alloc]init];
    alertLabel.text = @"温馨提示: 实名信息提交后不能随意修改, 为确保你预约后能成功取号请务必填写真时信息";
    alertLabel.font = [UIFont systemFontOfSize:15];
    alertLabel.numberOfLines = 0;
    //alertLabel.tintColor = FHColor(100,1,24);
    alertLabel.textColor = FHColor(100,100,244);
    [self.view addSubview:alertLabel];
    [alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(alertImageView.mas_right);
        make.right.equalTo(IDText.mas_right);
        make.top.equalTo(alertImageView.mas_top);
        
        
    }];
    
    //5.添加最下放按钮
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIImage *image = [UIImage imageNamed:@"fankui_bg"];
    //设置图片拉伸
    image = [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5 ];
    
    //fankui_bg
    [btn setBackgroundImage: image forState:UIControlStateNormal];
    //UIColor *color = [FHColor(123, 200, 123)];
    //[btn setBackgroundColor:[UIColor grayColor]];
    //[btn setBackgroundColor:FHColor(20, 210, 238)];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(alertLabel.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.offset(44);
        
    }];
    
    
}



//按钮点击事件
- (void)btnClick{
    
    FHCaseFloderController *vc = [[FHCaseFloderController alloc]init];
   //FHNavigationController *nav = [[FHNavigationController alloc]initWithRootViewController:vc];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
//    if (self.nameText.text.length == 0) {
//        [SVProgressHUD showErrorWithStatus:@"姓名不能为空"];
//        return;
//    }
//    
//   //http://apis.haoservice.com/idcard/s?cardno=11000019810419093X&key=66036e1fbb0b47e68051c05e7db7b057
//    
//    NSString *url = @"http://apis.haoservice.com/idcard/s";
//    
//    //	key	string	是	API KEY
//    //cardno	String	是	身份证号码
//    
//    NSDictionary *parameters = @{@"key":@"66036e1fbb0b47e68051c05e7db7b057",@"cardno":self.IDText.text};
//    
//    [self.sessionManager GET:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        //NSString *str =  [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//       // NSLog(@"str:%@",str);
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//        NSLog(@"%@",[dict[@"error_code"] class]);
//        
//        //error_code
//        if ([dict[@"error_code"]  isEqual: @(0)]) {
//           // NSLog(@"......唱个歌
//                FHBaiController *vc = [[FHBaiController alloc]init];
//                //FHNavigationController *nav = [[FHNavigationController alloc]initWithRootViewController:vc];
//                [self.navigationController pushViewController:vc animated:YES];
//            
//        }else{
//            [SVProgressHUD showErrorWithStatus:@"身份证不合法"];
//        }
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//    }];
    
    
    
    
    
    
//// //// //// //// //// //// //// //// //// //// //// ///
////    dispatch_async(dispatch_get_main_queue(), ^{
////        
////    })
//    [NSThread sleepForTimeInterval:0.1];
//    if (self.nameText.text.length == 0) {
////        [SVProgressHUD showErrorWithStatus:@"姓名不能为空"];
////        
////        [SVProgressHUD setBackgroundColor:[UIColor blueColor]];
////        [SVProgressHUD setForegroundColor:[UIColor redColor]];
//        [self showAlertViewWith:@"姓名不能为空"];
//        return;
//    }
//    
//    if (self.IDText.text.length == 0) {
//        //[SVProgressHUD showErrorWithStatus:@"身份证号不能为空"];
//        [self showAlertViewWith:@"身份证号不能为空"];
//        return;
//        
//    }
//    
//    
//  BOOL isSuccedd =  [self validateIdentityCard:self.IDText.text];
//
//    if (!isSuccedd) {
//        //弹出提示框
//        //[SVProgressHUD showErrorWithStatus:@"身份证号码不合法"];
//        [self showAlertViewWith:@"身份证号码不合法"];
//        return;
//    }
//    
//    
//    [self.view endEditing:YES];
//    
//    FHBaiController *vc = [[FHBaiController alloc]init];
//    //FHNavigationController *nav = [[FHNavigationController alloc]initWithRootViewController:vc];
//    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)showAlertViewWith:(NSString *)alertStr{
    
    
    [SVProgressHUD setBackgroundColor:[UIColor grayColor]];
    [SVProgressHUD setForegroundColor:[UIColor redColor]];
    [SVProgressHUD showErrorWithStatus:alertStr];
}


//文本监听事件
- (void)nameTextChange{
    //NSLog(@"姓名文本改变了");
    self.name = self.nameText.text;
    
    
}

//身份文本监听事件
- (void)IDTextChange{
    //NSLog(@"身份文本改变了");
    
    self.IDStr = self.IDText.text;
    
    
}


//检测身份证是否合法
- (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}



//设置导航栏
- (void)setNav{
    //设置导航的左边按钮
    self.title = @"病例管理";
    //创建导航栏的左边按钮
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    //[leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"nav_return"] forState:UIControlStateNormal];
    //leftBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //一定要设置大小
    //[leftBtn sizeToFit];
    
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
}

- (void)leftBtnClick{
    //NSLog(@"点解了左边的按钮");
    //发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dismissVC" object:nil];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






- (AFHTTPSessionManager *)sessionManager {
    
    if (_sessionManager == nil) {
        _sessionManager = [AFHTTPSessionManager manager];
        
        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSSet *set = [NSSet setWithObjects:@"text/plain", @"text/html", nil];
       // NSLog(@"%@",set);
        
        _sessionManager.responseSerializer.acceptableContentTypes = [_sessionManager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:set];
        
    }
    return _sessionManager;
    
    
}


@end

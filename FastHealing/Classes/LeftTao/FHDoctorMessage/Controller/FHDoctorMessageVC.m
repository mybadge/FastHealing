//
//  FHDoctorMessageVC.m
//  FastHealing
//
//  Created by tao on 16/1/21.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHDoctorMessageVC.h"
#import "FHDoctorMessage.h"
#import "AFNetworking.h"
#import "FHDoctorMessageModel.h"
#import "MJExtension.h"
#import "FHNetworkTools.h"
#import "FHRequireModel.h"
#import "SVProgressHUD.h"
@interface FHDoctorMessageVC ()
@property(nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (strong, nonatomic) NSArray *introductionArr;

@property (strong, nonatomic) FHDoctorMessage *docMesView;
@property (assign, nonatomic)  BOOL lastSelect;
//id参数
@property (strong, nonatomic)  NSNumber *num;
//@property (strong, nonatomic) UIButton *btn;
@end

@implementation FHDoctorMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"医生简介";
    
    //self.view.backgroundColor = [UIColor whiteColor];
    FHDoctorMessage *docMesView = [FHDoctorMessage loadDoctorMessage];
    self.docMesView = docMesView;
    //__weak weakSelf = self;
    __weak typeof(self) weakSelf = self;
    self.docMesView.sendMessageBlock = ^(UIViewController *vc){
        
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    //把医生的模型传过去
    docMesView.collectionDocModel = self.collectionModel;
    self.view = docMesView;
    [self setNav];
    //self.navigationItem.rightBarButtonItem.selected = YES;
    NSNumber *num = [NSNumber numberWithInteger:[self.collectionModel.doctor_id integerValue]];
    self.num = num;
    //NSLog(@"numunununun %@",num);
    //请求网络数据
    [self getIntroduction];
    
    [self getDocRequestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//设置导航栏
- (void)setNav{
    //设置导航的左边按钮
    self.title = @"医生信息列表";
    //创建导航栏的有边按钮
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"icon_pathMenu_collect_normal"] forState:UIControlStateNormal];
     [rightBtn setBackgroundImage:[UIImage imageNamed:@"icon_pathMenu_collect_highlighted"] forState:UIControlStateSelected];
    rightBtn.selected = YES;
    self.lastSelect = rightBtn.selected;
    //[rightBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //一定要设置大小
    [rightBtn sizeToFit];
    
    [rightBtn addTarget:self action:@selector(rightBtnBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
}

- (void)rightBtnBtnClick:(UIButton *)btn{
    //NSLog(@"点击了收藏按钮");
     btn.selected = !self.lastSelect;
     self.lastSelect = btn.selected;
    //判断一下
    if (btn.selected) {
         [self addDoctor];
    
    }else{
        //取消关注了,删除数据
        [self deleteDoctor];
    }
}
#pragma mark 请求医生的条件
- (void)getDocRequestData{
    
    NSString *url = @"http://iosapi.itcast.cn/doctorReceivingSetting.json.php";
   //NSNumber *num = [NSNumber n]
    NSNumber *num = [NSNumber numberWithInteger:[@"300000315" integerValue]];
   // NSDictionary *dict = @{@"doctor_id":num};
   // NSLog(@"111111111%@",self.collectionModel.doctor_id);
    NSDictionary *paramDic = @{@"login_token":FHLoginToken,@"doctor_id":num};
    
    [self.sessionManager POST:url parameters:paramDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if ([dict[@"code"] integerValue] == 0) {
      // NSLog(@"%@",dict[@"code"]);
            FHRequireModel *model =   [FHRequireModel mj_objectWithKeyValues:dict[@"data"]];           
#pragma mark 把模型传出去
            //FHDoctorMessage
            self.docMesView.requireModel = model;
            
        }else{
            NSLog(@"请求就诊条件,请求参数出错");
        }
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.description);
    }];
}

#pragma mark 请求数据
- (void)getIntroduction {
    
    NSString *url = @"http://iosapi.itcast.cn/getIntroduction.json.php";
    NSNumber *num = [NSNumber numberWithInteger:[@"300000315" integerValue]];
    NSDictionary *paramDic = @{@"login_token":FHLoginToken,@"doctor_id":num};
    
    [self.sessionManager POST:url parameters:paramDic  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
 
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
       // NSLog(@"reponse:%@",response);
        //NSLog(@"oooooooooooo%@",dict[@"data"]);
        //转模型
        FHDoctorMessageModel *model = [[FHDoctorMessageModel alloc]init];
        
        [model mj_setKeyValues:dict[@"data"]];
       // NSLog(@"0000000000%@",model.introduction);
        
#pragma mark 把模型传出去
        self.docMesView.docMessageModel = model;
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"错误%@",error.description);
    }];
}

//关注医生数据请请求

- (void)addDoctor {
    NSString *url = @"http://iosapi.itcast.cn/addDoctor.json.php";
    //header 赋值
    //   [sessionManager.requestSerializer setValue:FHLoginToken forHTTPHeaderField:@"login_token"];
    
    //"user_id":1000089,"doctor_id":300000315
    NSDictionary *paramDic = @{@"login_token":FHLoginToken,@"user_id":@(1000089),@"doctor_id":@(300000315)};
    
    [self.sessionManager POST:url parameters:paramDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     //成功
        
         NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        //NSLog(@"iiiiii%@",dict[@"code"]);
        
        if (self.actionDocBlock && [dict[@"code"] isEqual:@(0)]) {
//            self.btn.selected = !self.lastSelect;
//            self.lastSelect = self.btn.selected;
            self.actionDocBlock(YES);
            //NSLog(@"关注医生成功");
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.description);
    }];
}

//取消关注
- (void)deleteDoctor {
    
    
    NSString *url = @"http://iosapi.itcast.cn/deleteDoctor.json.php";
  
    NSDictionary *paramDic = @{@"login_token":FHLoginToken,@"user_id":@(1000089),@"doctor_id":@(300000315)};
    
    [self.sessionManager POST:url parameters:paramDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       // NSLog(@"%@",responseObject);
        //成功
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
       // NSLog(@"iiiiii%@",dict[@"code"]);
        
        if (self.actionDocBlock && [dict[@"code"] isEqual:@(0)]) {
//            self.btn.selected = !self.lastSelect;
//            self.lastSelect = self.btn.selected;
            self.actionDocBlock(NO);
            //NSLog(@"关注医生成功");
        }
      
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.description);
    }];
}



#pragma 栏架在
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


#pragma mark 设置提示框

- (void)setHUD{
    [SVProgressHUD show];
}


//数据懒加载
- (NSArray *)introductionArr{
    if (_introductionArr == nil) {
        _introductionArr = [NSArray array];
        
    }
    return _introductionArr;
}

@end

//
//  FHDetailSelectViewController.m
//  dcDemo
//
//  Created by ZhangZiang on 16/1/19.
//  Copyright © 2016年 ZhangZiang. All rights reserved.
//

#import "FHDetailSelectViewController.h"
#import "FHSelectTextView.h"
#import "FHNetworkTools.h"
#import "Masonry.h"
#import "FHSickDetailController.h"
#import "FHSickSimultaneousController.h"
#import "SVProgressHUD.h"
#import "FHDetailSick.h"
#import "FHSickSimultaneous.h"
#import "FHTreatMethodController.h"
#import "FHSelectDetailDecideView.h"
#import "FHMatchDoctorsController.h"
#import "FHPagerWebViewController.h"

@interface FHDetailSelectViewController ()

@property (nonatomic, strong) UILabel *sickType;
//
@property (nonatomic, weak) FHSelectTextView *sickDetailView;

//
@property (nonatomic, weak) FHSelectTextView *sickSimultaneous;


@property (nonatomic, weak) FHSelectTextView *sickTreatMethod;

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@property (nonatomic, assign) BOOL hasSelectedFirst;

@property (nonatomic, strong) FHDetailSick *detailSickModel;

@property (nonatomic, weak) FHSelectDetailDecideView *decideView;

//医生接口的参数
@property (nonatomic, assign) NSInteger is_confirmed;//是否确诊
@property (nonatomic, assign) NSInteger has_diagnosis;//是否接收过治疗
@property (nonatomic, assign) NSInteger ci2_id;//疾病细分1级
@property (nonatomic, assign) NSInteger ci3_id;//疾病细分2及
@property (nonatomic, assign) NSInteger diagnosis_type;//接收的治疗类型

@end

@implementation FHDetailSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"疾病详情";
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1];
    
    [self setupUI];
    
    /*@{@"login_token":FHLoginToken,@"ci1_id":@(1),@"ci2_id":@(3),@"ci3_id":@(3),@"diagnosis_type":@(0),@"is_confirmed":@(1),@"user_id":@(1000089),@"complications":@[@"",@"",@"",@"",@"",@""],@"has_diagnosis":@(2)};
     */
    
    self.ci2_id = 3;
    self.ci3_id = 3;
    self.diagnosis_type = 0;
    self.has_diagnosis = 2;
    self.is_confirmed = 1;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"预约须知" style:UIBarButtonItemStylePlain target:self action:@selector(makeAppointment)];
}

- (void)makeAppointment {
    //FHLog(@"%s",__func__);
    FHPagerWebViewController *webvc = [[FHPagerWebViewController alloc] init];
    webvc.html = @"arrage.html";
    webvc.title = @"预约须知";
    [self.navigationController pushViewController:webvc animated:YES];
    
    
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [SVProgressHUD dismiss];
}

#pragma mark 界面设置
- (void)setupUI {
    
    //创建label
    [self createSickTypeLabel];
    
    //创建疾病细分view
    FHSelectTextView *sickDetailView = [[FHSelectTextView alloc]initWithPlaceHolder:@"请选择疾病细分"];
    
    self.sickDetailView = sickDetailView;
    [self.view addSubview:sickDetailView];
    
    UITapGestureRecognizer *tapSickDetailView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sickDetailViewTaped)];
    
    [sickDetailView addGestureRecognizer:tapSickDetailView];
    
    //选择并发症
    FHSelectTextView *sickSimultaneous = [[FHSelectTextView alloc] initWithPlaceHolder:@"请选择并发症(可多选)"];
    
    self.sickSimultaneous = sickSimultaneous;
    [self.view addSubview:sickSimultaneous];
    
    UITapGestureRecognizer *tapsickSimultaneous = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sickSimultaneousTaped)];
    
    [sickSimultaneous addGestureRecognizer:tapsickSimultaneous];
    
    //请选择治疗方式
    FHSelectTextView *sickTreatMethod = [[FHSelectTextView alloc] initWithPlaceHolder:@"请选择治疗方式"];
    
    self.sickTreatMethod = sickTreatMethod;
    [self.view addSubview:sickTreatMethod];
    
    UITapGestureRecognizer *tapsickTreatMethod = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sickTreatMethodTaped)];
    
    [sickTreatMethod addGestureRecognizer:tapsickTreatMethod];
    //默认是隐藏的
    sickTreatMethod.hidden = YES;
    
    //创建是否确诊view
    FHSelectTextView *isSickCertainView = [[FHSelectTextView alloc]initWithPlaceHolder:@"是否确诊"];
    
    [self.view addSubview:isSickCertainView];
    
    [isSickCertainView createSelectButtonWithFirstString:@"已确诊" secondString:@"症状疑似"];
    
    isSickCertainView.block = ^(NSInteger btnTag){
        self.is_confirmed = btnTag == 1 ? 1 : 2;
        //        NSLog(@"%ld",self.is_confirmed);
    };
    
    //是否接受过治疗
    FHSelectTextView *isSickTreatView = [[FHSelectTextView alloc]initWithPlaceHolder:@"是否接受过治疗"];
    
    [self.view addSubview:isSickTreatView];
    
    [isSickTreatView createSelectButtonWithFirstString:@"接受过" secondString:@"未接受过"];
    
    isSickTreatView.block = ^(NSInteger btnTag){
        
        if (btnTag == 1) {
            sickTreatMethod.hidden = NO;
            self.has_diagnosis = 1;
            self.decideView.treatMethod = self.diagnosis_type;
            self.decideView.hasTreatMethod = YES;
        }
        else {
            sickTreatMethod.hidden = YES;
            self.has_diagnosis = 2;
            self.decideView.treatMethod = 0;
            self.diagnosis_type = 0;
            self.decideView.hasTreatMethod = NO;
            self.sickTreatMethod.placeHolder.text = @"请选择治疗方式";
            self.sickTreatMethod.placeHolder.textColor = [UIColor lightGrayColor];
        }
    };
    
    
    //下面的确认View
    FHSelectDetailDecideView *decideView = [[FHSelectDetailDecideView alloc]init];
    
    self.decideView = decideView;
    [self.view addSubview:decideView];
    
    decideView.blockClicked = ^() {
        
        FHMatchDoctorsController *matchDC = [[FHMatchDoctorsController alloc]init];
        
        [self.navigationController pushViewController:matchDC animated:YES];
        
        /* NSDictionary *parameter = @{@"login_token":FHLoginToken,@"ci1_id":@(self.ci1_id),@"ci2_id":@(self.ci2_id),@"ci3_id":@(self.ci3_id),@"diagnosis_type":@(self.diagnosis_type),@"is_confirmed":@(self.is_confirmed),@"user_id":@1000089, @"complications":@[@"",@"",@"",@"",@"",@""],@"has_diagnosis":@(self.has_diagnosis)}; */
        
        matchDC.paramDict = @{@"ci1_id":@(self.ci1_id),@"ci2_id":@(self.ci2_id),@"ci3_id":@(self.ci3_id),@"diagnosis_type":@(self.diagnosis_type),@"page_size":@15,@"is_confirmed":@(self.is_confirmed),@"user_id":@1000089, @"page":@1,@"has_diagnosis":@(self.has_diagnosis)};
        //传递名称
        NSString *isConfirmedStr = self.is_confirmed == 1 ? @"已确诊" : @"症状疑似";
        NSString *hasDiagnosis = self.has_diagnosis == 1 ? self.sickTreatMethod.placeHolder.text : @"未接受过治疗";
        matchDC.RealSickTypeDict = @{@"ci3_name":self.detailSickModel.ci3_name,@"is_confirmed_name":isConfirmedStr,@"has_diagnosis_name":hasDiagnosis};
        //        NSLog(@"%@",matchDC.RealSickTypeDict);
    };
    
    //添加约束
    CGFloat margin = FHScreenSize.height*0.022;
    CGFloat textHeight = FHScreenSize.height*0.066;
    
    [sickDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sickType.mas_bottom).with.offset(margin);
        make.left.equalTo(self.sickType);
        make.right.equalTo(self.view).with.offset(-margin);
        make.height.mas_equalTo(textHeight);
    }];
    
    [sickSimultaneous mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sickDetailView.mas_bottom).with.offset(margin);
        make.left.equalTo(self.sickType);
        make.right.equalTo(self.view).with.offset(-margin);
        make.height.mas_equalTo(textHeight);
    }];
    
    [isSickCertainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sickSimultaneous.mas_bottom).with.offset(margin);
        make.left.equalTo(self.sickType);
        make.right.equalTo(self.view).with.offset(-margin);
        make.height.mas_equalTo(textHeight);
    }];
    
    [isSickTreatView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(isSickCertainView.mas_bottom).with.offset(margin);
        make.left.equalTo(self.sickType);
        make.right.equalTo(self.view).with.offset(-margin);
        make.height.mas_equalTo(textHeight);
    }];
    
    [sickTreatMethod mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(isSickTreatView.mas_bottom).with.offset(margin);
        make.left.equalTo(self.sickType);
        make.right.equalTo(self.view).with.offset(-margin);
        make.height.mas_equalTo(textHeight);
    }];
    
    [decideView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sickTreatMethod.mas_bottom).with.offset(margin);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (void)createSickTypeLabel {
    UILabel *sickType = [[UILabel alloc]init];
    self.sickType = sickType;
    
    NSString *typeName = @"";
    
    switch (self.ci1_id) {
        case 1:
            typeName = @"肿瘤";
            break;
        case 2:
            typeName = @"血液科";
            break;
        case 3:
            typeName = @"心血管";
            break;
        case 4:
            typeName = @"神经科";
            break;
        case 5:
            typeName = @"骨科";
            break;
            
        default:
            break;
    }
    
    sickType.text = [NSString stringWithFormat:@"疾病类型: %@",typeName];
    sickType.textColor = [UIColor blackColor];
    sickType.font = [UIFont systemFontOfSize:15];
    
    CGFloat margin = 15;
    
    [self.view addSubview:sickType];
    
    [sickType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(margin+64);
        make.left.equalTo(self.view).with.offset(margin);
    }];
    
    
}

#pragma mark 点击逻辑

- (void)sickDetailViewTaped {
    
    FHSickDetailController *sickDetailVC = [[FHSickDetailController alloc]init];
    
    sickDetailVC.ci1_id = self.ci1_id;
    
    [self.navigationController pushViewController:sickDetailVC animated:YES];
    
    //拿到逆传值
    sickDetailVC.blockSelected = ^(FHDetailSick *sick) {
        self.detailSickModel = sick;
        
        self.sickDetailView.placeHolder.text = sick.ci3_name;
        self.sickDetailView.placeHolder.textColor = [UIColor blackColor];
        
        self.hasSelectedFirst = YES;
        
        self.ci2_id = sick.ci2_id;
        self.ci3_id = sick.ci3_id;
        
        //发送网络请求,看找到多少医生
        [self postNetworkRequest];
    };
}

- (void)sickSimultaneousTaped {
    
    if (self.hasSelectedFirst) {
        FHSickSimultaneousController *sickSim = [[FHSickSimultaneousController alloc]init];
        
        [self.navigationController pushViewController:sickSim animated:YES];
        
        sickSim.ci2_id = self.detailSickModel.ci2_id;
        
        //block赋值
        sickSim.blockSelected = ^(NSArray *sickSimModels) {
            //            NSLog(@"%@",sickSimModels);
            
            NSMutableString *selectedName = [NSMutableString string];
            
            for (FHSickSimultaneous *model in sickSimModels) {
                [selectedName appendString:model.complication_name];
                
                [selectedName appendString:@","];
            }
            
            [selectedName deleteCharactersInRange:NSMakeRange(selectedName.length-1, 1)];
            
            //            NSLog(@"%@",selectedName);
            
            self.sickSimultaneous.placeHolder.text = selectedName;
            self.sickSimultaneous.placeHolder.textColor = [UIColor blackColor];
            
            self.sickSimultaneous.amountLabel.hidden = NO;
            self.sickSimultaneous.amountLabel.text = [NSString stringWithFormat:@"(共%ld条)",sickSimModels.count];
        };
    }
    else {
        [SVProgressHUD showInfoWithStatus:@"请先选择疾病细分"];
    }
}

- (void)sickTreatMethodTaped {
    
    FHTreatMethodController *treatVC = [[FHTreatMethodController alloc]init];
    
    [self.navigationController pushViewController:treatVC animated:YES];
    
    treatVC.blockSelected = ^(NSInteger tag) {
        
        NSString *treatName = @"";
        
        switch (tag) {
            case 2:
                treatName = @"手术治疗";
                self.diagnosis_type = tag;
                self.decideView.treatMethod = tag;
                break;
            case 3:
                treatName = @"保守治疗";
                self.diagnosis_type = tag;
                self.decideView.treatMethod = tag;
                break;
            case 4:
                treatName = @"药物治疗";
                self.diagnosis_type = tag;
                self.decideView.treatMethod = tag;
                break;
            default:
                break;
        }
        
        self.sickTreatMethod.placeHolder.text = treatName;
        self.sickTreatMethod.placeHolder.textColor = [UIColor blackColor];
    };
}

#pragma mark 网络请求
- (void)postNetworkRequest {
    FHNetworkTools *manager = [FHNetworkTools sharedNetworkTools];
    
    NSString *urlStr = @"http://iosapi.itcast.cn/matchedDoctorCount.json.php";
    
#warning - if interface nomal update behind code 接口正常后下面的代码要注掉
    /*接口有问题...*/
    self.ci2_id = 3;
    self.ci3_id = 3;
    self.has_diagnosis = 2;
    //    self.diagnosis_type = 0;
    /*接口有问题...*/
    
    NSDictionary *parameter = @{@"login_token":FHLoginToken,@"ci1_id":@(self.ci1_id),@"ci2_id":@(self.ci2_id),@"ci3_id":@(self.ci3_id),@"diagnosis_type":@(self.diagnosis_type),@"is_confirmed":@(self.is_confirmed),@"user_id":@1000089, @"complications":@[@"",@"",@"",@"",@"",@""],@"has_diagnosis":@(self.has_diagnosis)};
    NSLog(@"%@",parameter);
    
    [manager POST:urlStr parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        //        NSLog(@"%@",responseObject);
        if (![responseObject[@"code"] integerValue]) {
            NSDictionary *dict = responseObject[@"data"];
            NSInteger doctorNum = [dict[@"doctor_count"] integerValue];
            
            self.decideView.doctorNum = doctorNum;
        }
        else {
            [SVProgressHUD showErrorWithStatus:@"没找到合适的医生..."];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [SVProgressHUD showErrorWithStatus:@"网络不稳定..."];
    }];
}

@end

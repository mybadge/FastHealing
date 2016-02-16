//
//  FHDiseaseDetailController.m
//  FastHealing
//
//  Created by 王 on 16/1/22.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHDiseaseDetailController.h"
#import "Masonry.h"
#import "FHFamilyHistoryController.h"
#import "FHFlowLayout.h"
#import "FHDiseaseTypeView.h"
#import "FHDiseaseDetailInfoController.h"
#import "SVProgressHUD.h"
#import "FHMainViewController.h"


#define VIEWMARGIN 10

@interface FHDiseaseDetailController ()<flowLayoutDelegate,diseaseTypeViewDelegate,UITextViewDelegate>

@property (strong, nonatomic) FHFamilyHistoryController *familyHistoryVC;
@property (strong, nonatomic) FHDiseaseDetailInfoController *diseaseDetailInfoVC;
@property (strong, nonatomic) UILabel *inputTip;

@end

@implementation FHDiseaseDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    //界面布局
    [self decorateUI];
    // Do any additional setup after loading the view.
}



//界面布局
- (void)decorateUI {
    self.title = @"疾病详情";
    self.view.backgroundColor = FHColor(245, 245, 245);
    
    //创建最上面的标题式view
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, FHScreenSize.width, 40)];
    topView.backgroundColor = FHColor(230, 230, 230);
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = FHPublicBenefitColor;
    titleLabel.text = @"请填写患儿疾病信息:";
    [topView addSubview:titleLabel];
    [self.view addSubview:topView];
    
    
    //创建家族疾病使View
    FHFlowLayout *layout = [[FHFlowLayout alloc]init];
    layout.delegate = self;
    
    FHFamilyHistoryController *familyHistoryVC = [[FHFamilyHistoryController alloc]initWithCollectionViewLayout:layout];
    layout.layoutName = @"layout";

    self.familyHistoryVC = familyHistoryVC;
    
    familyHistoryVC.collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:familyHistoryVC.view];

    
    //创建患病治疗史View
    UILabel *sickHistory = [[UILabel alloc]init];
    sickHistory.text = @"患儿治疗史:";
    [self.view addSubview:sickHistory];
    UITextView *sickHistoryText = [[UITextView alloc]init];
//    sickHistoryText.text = @"请输入病情";
    sickHistoryText.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:sickHistoryText];
    //设置占位label
    UILabel *inputTip = [[UILabel alloc]init];
    self.inputTip = inputTip;
    inputTip.text = @"请简要描述(100字以内)";
    inputTip.font = [UIFont systemFontOfSize:15];
    inputTip.textColor = [UIColor grayColor];
    [sickHistoryText addSubview:inputTip];

//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hehehe) name:UITextViewTextDidBeginEditingNotification object:nil];
    
    sickHistoryText.delegate = self;
    

    
    //创建病因类型View
    FHDiseaseTypeView *diseaseTypeView = [[FHDiseaseTypeView alloc]init];
    diseaseTypeView.delegate = self;
    diseaseTypeView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:diseaseTypeView];
    
    //创建详细病因View
    FHFlowLayout *diseaseDetailLayout = [[FHFlowLayout alloc]init];
    diseaseDetailLayout.layoutName = @"diseaseDetailLayout";
    diseaseDetailLayout.delegate = self;

    FHDiseaseDetailInfoController *diseaseDetailInfo = [[FHDiseaseDetailInfoController alloc]initWithCollectionViewLayout:diseaseDetailLayout];
    
    [self.view addSubview:diseaseDetailInfo.view];
    self.diseaseDetailInfoVC = diseaseDetailInfo;
    
    //创建完成申请按钮
    UIButton *finishApply = [[UIButton alloc]init];
    [finishApply setTitle:@"完成申请" forState:UIControlStateNormal];
    [finishApply setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [finishApply setBackgroundColor:FHPublicBenefitColor];
    [self.view addSubview:finishApply];
    [finishApply addTarget:self action:@selector(finishApplyButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    //设置约束
    //标题相对于最上面View的约束
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_top).offset(VIEWMARGIN);
        make.left.equalTo(topView.mas_left).offset(VIEWMARGIN);
    }];
    
    //家族疾病史相对于最上面View的约束
    [familyHistoryVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(VIEWMARGIN);
        make.right.equalTo(self.view.mas_right).offset(-VIEWMARGIN);
        make.top.equalTo(topView.mas_bottom).offset(VIEWMARGIN);
        make.height.mas_equalTo(VIEWMARGIN * 6);
    }];
    
    //患儿治疗史label约束
    [sickHistory mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(familyHistoryVC.view.mas_bottom).offset(VIEWMARGIN);
        make.left.equalTo(self.view).offset(VIEWMARGIN);
    }];
    
    //患儿治疗史textView约束
    [sickHistoryText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sickHistory.mas_bottom).offset(VIEWMARGIN);
        make.left.equalTo(self.view).offset(VIEWMARGIN);
        make.right.equalTo(self.view).offset(-VIEWMARGIN);
        make.height.mas_equalTo(FHScreenSize.height * 0.15);
    }];
    
    //textView占位label约束
    [inputTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sickHistoryText.mas_top).offset(8);
        make.left.equalTo(sickHistoryText.mas_left).offset(5);
    }];
    
    //病因类型view约束
    [diseaseTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sickHistoryText.mas_bottom).offset(VIEWMARGIN);
        make.left.equalTo(self.view.mas_left).offset(VIEWMARGIN);
        make.right.equalTo(self.view.mas_right).offset(-VIEWMARGIN);
        make.height.mas_equalTo(FHScreenSize.height * 0.06);
    }];
    
    //详细病因View约束
    [diseaseDetailInfo.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(diseaseTypeView.mas_bottom).offset(VIEWMARGIN);
        make.left.equalTo(self.view).offset(VIEWMARGIN);
        make.right.equalTo(self.view).offset(-VIEWMARGIN);
        make.height.mas_equalTo(FHScreenSize.height * 0.3);
    }];
    
    //完成按钮约束
    [finishApply mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(VIEWMARGIN);
        make.right.equalTo(self.view.mas_right).offset(-VIEWMARGIN);
        make.bottom.equalTo(self.view.mas_bottom).offset(-VIEWMARGIN * 2);
    }];
    

}

//实现flowlayout代理方法更新collectionView约束
-(void)flowLayout:(FHFlowLayout *)layout maxValueY:(CGFloat)valueY layoutName:(NSString *)name {
//    NSLog(@"----%f------%@",valueY,name);
    if ([name isEqualToString:@"layout"]) {
        [self.familyHistoryVC.view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(valueY);
        }];
    }
    if ([name isEqualToString:@"diseaseDetailLayout"]) {
        [self.diseaseDetailInfoVC.view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(valueY);
        }];
    }
    
}

-(void)textViewDidChange:(UITextView *)textView{
//    NSLog(@"123");
    if (textView.text.length == 0) {
        self.inputTip.hidden = NO;
    }else {
        self.inputTip.hidden = YES;
    }
}

-(void)hehehe {
//    NSLog(@"123");
    
}

//完成按钮点击事件
- (void)finishApplyButtonClick {
    NSLog(@"点击了完成按钮");
    [SVProgressHUD showInfoWithStatus:@"完成申请" maskType:SVProgressHUDMaskTypeBlack];
    FHMainViewController *vc = [[FHMainViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
}

//病情类型按钮点击代理方法
-(void)diseaseTypeView:(FHDiseaseTypeView *)diseaseTypeView clickButton:(UIButton *)btn {
//    NSLog(@"------%ld",btn.tag);
    self.diseaseDetailInfoVC.btnSelectedTag = btn.tag;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

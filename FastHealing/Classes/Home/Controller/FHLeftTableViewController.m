//
//  FHLeftTableViewController.m
//  FastHealingD
//
//  Created by 赫腾飞 on 16/1/19.
//  Copyright © 2016年 hetefe. All rights reserved.
//

#import "FHLeftTableViewController.h"
#import "FHLeftMenu.h"
#import "FHLeftHeadView.h"
#import "FHSettingsAndHelp.h"
#import "FHCaseManageVC.h"
#import "FHFamousDoctorsTC.h"
#import "FHMyCollectionTC.h"
#import "FHViewController.h"
#import "FHUserViewModel.h"
#import "FHLeftHeadViewWDL.h"
#import "FHPersonaViewController.h"
#import "UMSocial.h"

#import "FHNavigationController.h"

@interface FHLeftTableViewController ()<UMSocialUIDelegate,FHLeftHeadViewDelegate>

@property (nonatomic, strong) NSArray *leftMenus;

// login headerView
@property (nonatomic, weak) FHLeftHeadView *leftHeadView;

@end

@implementation FHLeftTableViewController
static NSString *cellID = @"leftCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    self.tableView.bounces = NO;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor = FHColor(236, 233, 240);
    
    //添加监听 ViewModel中 user 属性值得改变, 来刷新列表. 来实现更换 登录状态
    FHUserViewModel *userViewModel = [FHUserViewModel shareUserModel];
    [userViewModel addObserver:self forKeyPath:@"user" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    [self.tableView reloadData];
}

- (void)dealloc {
    [[FHUserViewModel shareUserModel] removeObserver:self forKeyPath:@"user"];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.width = FHScreenSize.width *0.8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section > 0) {
        return 20;
    }
    if ([FHUserViewModel shareUserModel].isLogin) {
        return 100;
    } else {
        return 140;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section > 0) {
        return nil;
    }
    if ([FHUserViewModel shareUserModel].isLogin) {
        FHLeftHeadView *leftHeadView = [FHLeftHeadView leftHeadView];
        self.leftHeadView = leftHeadView;
        //设置代理 完成点击按钮跳转操作
        self.leftHeadView.delegate = self;
        leftHeadView.user = [FHUserViewModel shareUserModel].user;
        return leftHeadView;
    } else {
        FHLeftHeadViewWDL *leftHeadViewWDL = [FHLeftHeadViewWDL leftHeadViewWDL];
        leftHeadViewWDL.btnClickBlock = ^(NSString *choosePage){
            if ([@"login" isEqualToString:choosePage]) {
                if (self.didSelectedVcBlock) {
                    self.didSelectedVcBlock(FHLoginVC);
                }
            } else {
                if (self.didSelectedVcBlock) {
                    UIViewController *registerVc = [[UIStoryboard storyboardWithName:@"FHLogin" bundle:nil] instantiateViewControllerWithIdentifier:@"RegisterVc"];
                    self.didSelectedVcBlock(registerVc);
                }
            }
        };
        return leftHeadViewWDL;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.leftMenus.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([FHUserViewModel shareUserModel].user) {
         return [self.leftMenus[section] count];
    } else {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    FHLeftMenu *leftMenu = self.leftMenus[indexPath.section][indexPath.row];
    cell.textLabel.text = leftMenu.title;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    //    UIImageView *bg = [[UIImageView alloc] init];
    //    bg.image = [UIImage imageNamed:@"bg_dropdown_left_selected"];
    //    cell.backgroundView = bg;
    //
    //    UIImageView *selectedBg = [[UIImageView alloc] init];
    //    selectedBg.image = [UIImage imageNamed:@"bg_dropdown_right_selected"];
    //    cell.selectedBackgroundView = selectedBg;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FHLeftMenu *leftMenu = self.leftMenus[indexPath.section][indexPath.row];
    
    
    /**
     *  下一步优化 就是,把action ViewController name 直接根据类名来创建对象,节省创建的方法.
     *  更加优化代码 ,这样是不是更精简
     */
    Class cl = NSClassFromString(leftMenu.vcClassName);
    if (cl) {
        UIViewController *vc = [[cl alloc] init];
        if (self.didSelectedVcBlock) {
            self.didSelectedVcBlock(vc);
        }
    } else {
        
        SEL action = NSSelectorFromString(leftMenu.action);
        if ([self respondsToSelector:action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:action];
#pragma clang diagnostic pop
        }
    }
}
/** 个人信息界面跳转 */
- (void)LeftHeadView:(FHLeftHeadView *)view didClickPIbutton:(UIButton *)sender{
    
    FHPersonaViewController *personal = [[FHPersonaViewController alloc] init];
    
    self.didSelectedVcBlock(personal);
    
}
///** 预约挂号列表 */
//- (void)makeAppointment {
//    FHLog(@"%s", __func__);
//}
///** 名医通申请 */
//- (void)famousDoctors {
//    FHFamousDoctorsTC *famousVC = [[FHFamousDoctorsTC alloc]init];
//    if (self.didSelectedVcBlock) {
//        self.didSelectedVcBlock(famousVC);
//    }
//}
///** 病例管理 */
//- (void)caseManagement {
//    FHCaseManageVC *caseVC = [[FHCaseManageVC alloc]init];
//    if (self.didSelectedVcBlock) {
//        self.didSelectedVcBlock(caseVC);
//    }
//}
//
///** 我的收藏 */
//- (void)myCollection {
//    FHMyCollectionTC *collectionVC = [[FHMyCollectionTC alloc]init];
//    if (self.didSelectedVcBlock) {
//        self.didSelectedVcBlock(collectionVC);
//    }
//}
///** 支付明细 */
//- (void)paymentDetails {
//    FHLog(@"%s", __func__);
//}
//
///** 设置与帮助 */
//- (void)settingsAndHelp {
//    FHSettingsAndHelp *settingsAndHelpVC = [[FHSettingsAndHelp alloc]init];
//    if (self.didSelectedVcBlock) {
//        self.didSelectedVcBlock(settingsAndHelpVC);
//    }
//}
///** 意见反馈 */
//- (void)feedback {
//    FHLog(@"%s", __func__);
//}
/** 关于产品 */
//- (void)aboutProduct {
//    FHViewController *aboutProductVC = [[FHViewController alloc]init];
//    if (self.didSelectedVcBlock) {
//        self.didSelectedVcBlock(aboutProductVC);
//    }
//    //[FHNotificationCenter postNotificationName:@"hidemenu" object:nil userInfo:@{@"vc": aboutProductVC}];
//}
//分享
- (void)shareFriends {
    [UMSocialSnsService presentSnsIconSheetView:self.view.window.rootViewController
                                         appKey:@"56a1ebae67e58ee4550022de"
                                      shareText:@"法医3组"
                                     shareImage:nil
                                shareToSnsNames:@[UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToDouban,UMShareToQzone,UMShareToSms]
                                       delegate:self];
}

- (NSArray *)leftMenus{
    if (!_leftMenus) {
        _leftMenus = [FHLeftMenu leftMenus];
    }
    return _leftMenus;
}
@end

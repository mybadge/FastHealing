//
//  FHMainViewController.m
//  FastHealingD
//
//  Created by 赵志丹 on 16/1/19.
//  Copyright © 2016年 FastHeading. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "FHMainViewController.h"
#import "FHSideMenu.h"
#import "FHWeatherView.h"
#import "Masonry.h"
#import "FHFamousDoctorView.h"
#import "FHDetailSelectViewController.h"
#import "AdScrollView.h"
#import "FHPagerWebViewController.h"
#import "FHPublicBenefitController.h"
#import "FHWeatherPositionViewController.h"
#import "FHNetworkTools.h"
#import "FHPagerModel.h"
#import "MJExtension.h"
#import "FHWeather_data.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"


#define PAGERVIEWHSCALE 660/1080.0  //轮播图片宽高比例



@interface FHMainViewController ()<FHWeatherViewDelegate>
/** 天气 */
@property (nonatomic, weak) FHWeatherView *weatherView;
@property (nonatomic, weak) FHWeatherView *weatherDetail;
/** 轮播图视图 */
@property (nonatomic, weak) AdScrollView *pagerView;

/** 轮播器数据 */
@property (nonatomic, strong) NSArray *banners;
/** 明师通标题 */
@property (nonatomic, weak) UIView *famousView;
/** 明师通内容 */
@property (nonatomic, weak) FHFamousDoctorView *famousDoctorsView;

@property (nonatomic, strong) Reachability *reachability;

@end

@implementation FHMainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"快医";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"个人信息" style:UIBarButtonItemStylePlain target:self action:@selector(controlLeftMenu:)];
    //self.navigat
    
    //天气
    [self setWeatherView];
    //轮播视图
    [self pagerView];
    //轮播数据
    [self requestPagerData];
    //明师通标题
    [self famousView];
    //名师通内容
    [self setupFamousDoctorsView];
    
    //接受更新天气的通知
    [ FHNotificationCenter addObserver:self selector:@selector(requestWeatherData:) name:@"setPosition" object:nil];
    //监听网络状态改变
    [self setupNotification];
    //检查网络
    if (!self.reachability.isReachable) {
         [self networkStateTip];
    }
}

/**
 *  初始化通知
 */
- (void)setupNotification{
    [FHNotificationCenter addObserver:self selector:@selector(checkNetworkState) name:kReachabilityChangedNotification object:nil];
    self.reachability = [Reachability reachabilityForInternetConnection];
    [self.reachability startNotifier];
}

/**
 *  检查网络状态
 */
- (void)checkNetworkState {

    if ([FHNetworkTools isEnableWIFI]) {
        NSLog(@"wifi环境");
        [SVProgressHUD showInfoWithStatus:@"wifi环境" maskType:SVProgressHUDMaskTypeGradient];
        //请求轮播数据
        if (self.banners.count == 0) {
            [self requestPagerData];
        }
    }else if ([FHNetworkTools isEnable4G]) {
        NSLog(@"4G环境");
        [SVProgressHUD showInfoWithStatus:@"蜂窝环境" maskType:SVProgressHUDMaskTypeGradient];
         //请求轮播数据
        if (self.banners.count == 0) {
            [self requestPagerData];
        }
    } else {
        [self networkStateTip];
    }
}

- (void)networkStateTip{
    UIAlertController *alert= [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"客官,您的手机没有联网" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];           [[UIApplication sharedApplication] openURL:url];
        }
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [alert addAction:cancleAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)setupFamousDoctorsView{
    FHFamousDoctorView *famousDoctorsView = [[FHFamousDoctorView alloc] init];
    self.famousDoctorsView = famousDoctorsView;
    
    CGFloat fy = CGRectGetMaxY(self.famousView.frame);
    CGFloat fh = FHScreenSize.height - fy;
    
    famousDoctorsView.frame = CGRectMake(0, fy, FHScreenSize.width,fh);
    famousDoctorsView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:famousDoctorsView];
    famousDoctorsView.blockClicked = ^(NSInteger tag) {
        if (tag == 6) {
            //跳转到公益活动
            FHPublicBenefitController *benefitVC = [[FHPublicBenefitController alloc]init];
            [self.navigationController pushViewController:benefitVC animated:YES];
        }else {
            FHDetailSelectViewController *detail = [[FHDetailSelectViewController alloc]init];
            detail.ci1_id = tag;
            [self.navigationController pushViewController:detail animated:YES];
        }
    };
}
#pragma mark -点击右边item返回主页面
//判断,当左边按钮打开时,点击右边item返回主页面
- (void)controlLeftMenu:(id)sender {
    //隐藏leftMenu
    if (self.isOpenLeft) {
        if (self.backMainVcBlock) {
            self.backMainVcBlock();
        }
        //显示 leftMenu
    } else {
        [self presentLeftMenuViewController:sender];
    }
}


#pragma mark 接受更新天气的通知 执行方法
- (void)requestWeatherData:(NSNotification *)notification{
    FHNetworkTools *manager = [FHNetworkTools sharedNetworkTools];
    [manager upWeatherWithString:notification.object andSuccess:^(NSArray *dalalist) {
        FHWeather_data *data = dalalist[0];
        
        if (data != nil) {
            self.weatherView.data = data;
        }else if (dalalist == nil){
        }
        NSString *city = notification.object;
        if ([notification.object length] > 3) {
            city = [notification.object substringToIndex:2];
            NSString *last = [notification.object substringFromIndex:[notification.object length] - 1];
            city = [NSString stringWithFormat:@"%@%@",city,last];
        }
        [self.weatherView.positionButton setTitle:city forState:UIControlStateNormal];
        
    } andFailure:^(NSError *error) {
        FHLog(@"%@",error);
         [SVProgressHUD showInfoWithStatus:@"未获取到对应天气信息！" maskType:SVProgressHUDMaskTypeBlack];
    }];
}

#pragma mark 添加WeatherView
- (void)setWeatherView{
    
    FHWeatherView *weatherView = [[FHWeatherView alloc]  initWithFrame: CGRectMake(0, 64, FHScreenSize.width, FHScreenSize.height * 0.1)];
    self.weatherView = weatherView;
    weatherView.delegate = self;
    
    self.weatherView.backgroundColor =  FHColor(232, 246, 253);
    
    [self.view addSubview:weatherView];
    
    weatherView.weatherDetail = ^(){
        
        NSLog(@"弹出天气详细界面");
    };
}

//更换天气查询地址 WeatherView Delegate方法
- (void)ClickPositionButton:(FHWeatherView *)weatherView{
    
    FHWeatherPositionViewController *positionVC = [[FHWeatherPositionViewController alloc] init];
    positionVC.title = @"中国";
    [self.navigationController pushViewController:positionVC animated:YES];
}

#pragma mark 添加PagerView
- (AdScrollView *)pagerView{
    if (!_pagerView) {
        AdScrollView *pagerView = [[AdScrollView alloc] initWithFrame:CGRectMake(0, 0, FHScreenSize.width, FHScreenSize.width * PAGERVIEWHSCALE)];
        _pagerView = pagerView;
        pagerView.y = CGRectGetMaxY(self.weatherView.frame);
        pagerView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:pagerView];
    }
    return _pagerView;
}

- (void)requestPagerData {
    [[FHNetworkTools sharedNetworkTools] getBannerWithDict:nil andSuccess:^(NSArray *datalist) {
        //排序
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"banner_id" ascending:NO];
        self.banners = [datalist sortedArrayUsingDescriptors:@[sort]];
        
        self.pagerView.ImageURLArray = [self.banners valueForKeyPath:@"banner_img_url"];
        
        self.pagerView.PageControlShowStyle  = UIPageControlShowStyleCenter;
        self.pagerView.pageControl.pageIndicatorTintColor  = [UIColor orangeColor];
        self.pagerView.pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
        //跳转网页信息
        [_pagerView addTapEventForImageWithBlock:^(NSInteger imageIndex) {
            //NSLog(@"%zd",imageIndex);
            FHPagerWebViewController *webVC = [[FHPagerWebViewController alloc] init];
            FHPagerModel *model = self.banners[imageIndex  == 3 ? 0 : imageIndex];
            /**
             1  0 id=8,  name=热门医生 李崇键---石红霞
             2  1 id=15, name=热门医生 公益 ----李崇键
             3  2 id=16, name=脑瘫公益活动 石红霞 --公益
             */
            //NSLog(@"id=%@, name=%@",model.banner_id, model.banner_title);
            webVC.URLString = model.banner_link;
            webVC.title = model.banner_title;
            [self.navigationController pushViewController:webVC animated:YES];
        }];
        
    } andFailure:^(NSError *error) {
        FHLog(@"%@",error);
    }];
}

- (UIView *)famousView{
    if (!_famousView) {
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 6, 18)];
        leftLabel.backgroundColor = FHColor(105, 206, 255);
        leftLabel.layer.cornerRadius = 3;
        leftLabel.layer.masksToBounds = YES;
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
        textLabel.text = @"名师通";
        
        UIView *famousView = [[UIView alloc] init];
        _famousView = famousView;
        famousView.backgroundColor = [UIColor whiteColor];
        [famousView addSubview:leftLabel];
        [famousView addSubview:textLabel];
        famousView.y = CGRectGetMaxY(self.pagerView.frame);
        famousView.width = FHScreenSize.width;
        famousView.height = 44;
        
        leftLabel.centerY = famousView.height * 0.5;
        textLabel.centerY = leftLabel.centerY;
        textLabel.x = CGRectGetMaxX(leftLabel.frame) + 5;
        
        UIView *sepViewTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, FHScreenSize.width, 0.5)];
        sepViewTop.backgroundColor = [UIColor blackColor];
        sepViewTop.alpha = 0.2;
        UIView *sepViewBottom = [[UIView alloc] initWithFrame:CGRectMake(0, famousView.height-1, FHScreenSize.width, 0.5)];
        sepViewBottom.backgroundColor = [UIColor blackColor];
        sepViewBottom.alpha = 0.2;
        [famousView addSubview:sepViewTop];
        [famousView addSubview:sepViewBottom];
        [self.view addSubview:famousView];
    }
    return _famousView;
}



- (NSArray *)banners{
    if (_banners == nil) {
        _banners = [NSArray array];
    }
    return _banners;
}

- (void)dealloc{
    
    [FHNotificationCenter removeObserver:self];
    FHLog(@"释放了");
}

@end

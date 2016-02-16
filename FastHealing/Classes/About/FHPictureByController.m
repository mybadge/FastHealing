//
//  FHPictureByController.m
//  FastHealing
//
//  Created by xiechen on 16/1/24.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHPictureByController.h"
#import "FHNetworkTools.h"
#import "UIImageView+WebCache.h"
#import "FHPictureModel.h"
#import "FHPictureBy.h"
#import "Masonry.h"
#import "UIView+Extension.h"
#import "FHXCHeaderView.h"
#import "FHXCCollectionViewController.h"
#define mySurrenSize [UIScreen mainScreen].bounds.size


@interface FHPictureByController ()
@property (nonatomic,strong)NSArray *picturImages;
@property (nonatomic,strong)FHPictureBy *picutreBy;
@property (nonatomic,strong)FHXCHeaderView *header;
@property (nonatomic,strong)UISegmentedControl *selectV;

@end

@implementation FHPictureByController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",[NSThread currentThread]);
    [self getImages];
    
    [self headerViewSetUI];
    
    [self selectView];
    
    [self footView];
   
}

- (void)viewDidAppear:(BOOL)animated{
    if (self.picturImages) {
        [self pictureByView:self.picturImages];
    }
}
//网络获取图片
- (void)getImages{
    NSString *urlStr = @"http://iosapi.itcast.cn/banners.json.php";
    NSDictionary *parameters = @{@"login_token":FHLoginToken,@"page_size":@(10),@"page":@(1)};
    [[FHNetworkTools sharedNetworkTools] POST:urlStr parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSArray *banners = responseObject[@"data"][@"banners"];
        NSArray *dictM = [FHPictureModel mj_objectArrayWithKeyValuesArray:banners];
        self.picturImages = dictM;
        [self pictureByView:dictM];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)pictureByView:(NSArray *)array{
    FHPictureBy *picutreBy = [[FHPictureBy alloc]initWithFrame:CGRectMake(0,129, [UIScreen mainScreen].bounds.size.width, 200)];
    self.picutreBy = picutreBy;
    picutreBy.pictures = array;
    picutreBy.pictureBlock = ^(UIWebView *web){
        UIViewController *vc = [[UIViewController alloc]init];
        vc.view =web;
        [self.navigationController pushViewController:vc animated:YES];
    };
    [self.view addSubview:picutreBy];
    NSLog(@"-------%@",NSStringFromCGRect(picutreBy.frame));
}


- (void)headerViewSetUI{

    FHXCHeaderView *header = [[FHXCHeaderView alloc]initWithFrame:CGRectMake(0, 64,mySurrenSize.width , 65)];
    self.header = header;
    header.backgroundColor = [UIColor redColor];
    [self.view addSubview:header];
    
}

- (void)selectView{
    NSArray *segentItem = @[@"个人信息",@"个人详情"];
    UISegmentedControl *selectV = [[UISegmentedControl alloc]initWithItems:segentItem];
    self.selectV = selectV;
    selectV.frame = CGRectMake(0, 0, mySurrenSize.width, 30);
    selectV.y = CGRectGetMaxY(self.header.frame) + 200;
    selectV.selectedSegmentIndex = 1;
    selectV.tintColor = [UIColor blueColor];
    [self.view addSubview:selectV];
    
}

- (void)footView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.itemSize = CGSizeMake(mySurrenSize.width,CGRectGetMaxY(self.selectV.frame));
    
    FHXCCollectionViewController *collection = [[FHXCCollectionViewController alloc]initWithCollectionViewLayout:layout];
    
    [self.view addSubview:collection.view];
    
    NSLog(@"123123123-------%@",NSStringFromCGSize(layout.itemSize));

    
}


@end

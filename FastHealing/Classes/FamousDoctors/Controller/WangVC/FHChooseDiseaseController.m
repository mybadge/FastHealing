//
//  FHChooseDiseaseController.m
//  FastHealing
//
//  Created by 王 on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHChooseDiseaseController.h"
#import "FHChooseDiseaseCell.h"
#import "FHDiseaseModel.h"
#import "FHChooseDiseasePopController.h"
#import "Masonry.h"
#import "FHSalvageBasicInfoController.h"

#define POPViewWidth 200
#define POPViewHeight 300

@interface FHChooseDiseaseController ()<UICollectionViewDataSource,UICollectionViewDelegate,chooseDiseaseCellDelegate,chooseDiseasePopDelegate>
@property (strong, nonatomic) NSArray *diseaseTitle;
@property (strong, nonatomic) NSArray *diseases;
@property (strong, nonatomic) FHChooseDiseasePopController *popVC;
@property (strong, nonatomic) UIView *backView;

@end

@implementation FHChooseDiseaseController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    //设置数据源,代理
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    //注册item
    UINib *nib = [UINib nibWithNibName:@"FHChooseDiseaseCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    
    //更改cell大小
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    //适配不同iPhone
    if ([UIScreen mainScreen].nativeScale == 3.0f) {
        layout.itemSize = CGSizeMake(180, 150);
    }else {
        layout.itemSize = CGSizeMake(160, 130);
    }


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FHChooseDiseaseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    //设置代理
    cell.delegate = self;
    
    // Configure the cell
//    cell.backgroundColor = FHPublicBenefitColor;
    UIView *backView = [[UIView alloc]initWithFrame:cell.bounds];
    backView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"chooseDiseaseCell_backView"].CGImage);
    cell.backgroundView = backView;
    
    //传递数据
    cell.disease = self.diseaseTitle[indexPath.item];
    
    
    return cell;
}

//实现点击cell的代理方法
-(void)chooseDisease:(FHChooseDiseaseCell *)cell {

    //添加遮罩
    UIView *backView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.backView = backView;
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0;
    
    UIViewController *father = self.parentViewController;
    [father.view addSubview:backView];
    
    //为遮罩添加手势
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backViewClick)];
    [backView addGestureRecognizer:gesture];
    
    
    //弹出的tableview控制器
    FHChooseDiseasePopController *popVC = [[FHChooseDiseasePopController alloc]init];
    self.popVC = popVC;
    popVC.disease = cell.disease;
    //设置代理
    popVC.delegate = self;
    [father.view addSubview:popVC.view];
    [popVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.width.mas_equalTo(POPViewWidth);
        make.height.mas_equalTo(POPViewHeight);
        
    }];
    
    //动画遮罩
    [UIView animateWithDuration:0.25 animations:^{
        backView.alpha = 0.5;
    }];
}


//黑色遮罩的手势点击时间
- (void)backViewClick {
//    NSLog(@"点击了");

    [self.popVC.view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        self.backView.alpha = 0;
        //调用此句可以使约束产生动画效果
        [self.popVC.view layoutIfNeeded];
    }];
    
    
    
    
}

//弹出疾病选择控制器的代理实现方法
- (void)chooseDiseasePopController:(FHChooseDiseasePopController *)popVC diseaseTitle:(NSString *)title andDiseaseName:(NSString *)diseaseName{
    //选中疾病后的跳转控制器的方法
    FHSalvageBasicInfoController *vc = [[FHSalvageBasicInfoController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    //将疾病名称和名字传递过去
    vc.diseaseTitle = title;
    vc.diseaseName = diseaseName;
    [self backViewClick];
}


//懒加载
-(NSArray *)diseaseTitle {
    if (_diseaseTitle == nil) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"DiseaseList.plist" ofType:nil];
        NSArray *dataTem = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dict in dataTem) {
            FHDiseaseModel *model = [FHDiseaseModel diseaseWithDict:dict];
            [arrM addObject:model];
        }
        _diseaseTitle = arrM;
        
    }
    return _diseaseTitle;
}

@end

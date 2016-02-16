//
//  FHDocIntroduceView.m
//  FastHealing
//
//  Created by tao on 16/1/22.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHDocIntroduceView.h"
#import "FHDocMessageCell.h"
#import "FHDoctorMessageModel.h"
#import "FHSpecialView.h"
#import "FHRequireModel.h"

@interface FHDocIntroduceView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) FHDocMessageCell *cell;
@end

@implementation FHDocIntroduceView


//- (instancetype)init{
//    if (self = [super init]) {
//        self.backgroundColor  = [UIColor whiteColor];
//        
//        self = [[[NSBundle mainBundle] loadNibNamed:@"FHDocIntroduceView" owner:nil options:nil] lastObject];
//        
//    }
//    //self.backgroundColor  = [UIColor whiteColor];
//    return  self;
//}

//+ (instancetype)loadIntroDuctView{
//    
//    FHDocIntroduceView *view = [[[NSBundle mainBundle]loadNibNamed:@"FHDocIntroduceView" owner:nil options:nil] lastObject];
//    view.backgroundColor = [UIColor whiteColor];
//    NSLog(@"llllllllllllll%@",view);
//    return  view;
//}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupUI];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        //注册cell   FHDocrorMessageYG
        //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"FHDocrorMessageYG"];
        //self.collectionView.
       [self.collectionView registerNib:[UINib nibWithNibName:@"FHDocMessageCell" bundle:nil]  forCellWithReuseIdentifier: @"FHDocrorMessageYG"];
        
    }
    return self;
}



- (void)setupUI{
//    UITableView *tableView = [[UITableView alloc]init];
//    tableView.frame = CGRectMake(0, 0, 40, 40);
//    [self addSubview:tableView];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    flowLayout.itemSize = CGSizeMake(FHScreenSize.width, FHScreenSize.height -64 - 80 -20 -44 - 120);
    
    //NSLog(@"lllllllllllloo%f",self.height);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumInteritemSpacing = 0;

    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FHScreenSize.width, FHScreenSize.height -64 - 80 -20 -44 - 120) collectionViewLayout:flowLayout];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.bounces = NO;
    self.collectionView = collectionView;
    self.collectionView.pagingEnabled = YES;
    
    collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:collectionView];
}

//实现collectionView的代理方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
    
  //返回数据,
   //return  self.messageModel.
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FHDocMessageCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"FHDocrorMessageYG" forIndexPath:indexPath];
    cell.backgroundColor =[UIColor whiteColor];

//#warning tyg将要做的
    
   // FHRequireModel *requiteModel = self.requireModel;
   // NSLog(@"555555%ld",requiteModel.receiving_settings.count);
    
    
    if (indexPath.row == 0) {
        self.messageModel.isIntroduction = NO;
    }else{
        self.messageModel.isIntroduction = YES;
    }
    //cell.
    
    cell.requireModel = self.requireModel;
    cell.messageModel = self.messageModel;
    //NSLog(@"%@",self.messageModel.introduction);
 //cell里面在添加一个模型,用来存放医生条件
    self.cell = cell;
    return cell;
    
}



- (void)setRequireModel:(FHRequireModel *)requireModel{
    _requireModel = requireModel;
    
    //NSLog(@"%@",requireModel.receiving_setting_extra);
    
    if (!(requireModel.receiving_setting_extra == nil || [requireModel.receiving_setting_extra isEqualToString:@""])) {
            //specialView也需要模型
        
            FHSpecialView *specialView = [FHSpecialView loadSpecialView];
            specialView.frame = CGRectMake(0, 0, FHScreenSize.width, FHScreenSize.height -64 - 80 -20 -44 - 120);
            //        specialView.backgroundColor = [UIColor redColor];
        specialView.requireModel = self.requireModel;
        self.messageModel = self.messageModel;
            [self.cell addSubview:specialView];
    }
    
    
    
   //NSLog(@"6666666666%ld",requireModel.receiving_settings.count);
    [self.collectionView reloadData];
}

@end

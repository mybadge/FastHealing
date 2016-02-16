//
//  FHChooseDiseaseCell.m
//  FastHealing
//
//  Created by 王 on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHChooseDiseaseCell.h"
#import "Masonry.h"
#include "FHChooseDiseaseHeaderView.h"
#include "FHChooseDiseasePopController.h"

@interface FHChooseDiseaseCell ()<UICollectionViewDataSource
,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *diseaseList;

@end

@implementation FHChooseDiseaseCell

- (void)awakeFromNib {
    // Initialization code
    
    //配置collectionview
    [self.diseaseList registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"diseaseList"];
    self.diseaseList.backgroundColor = [UIColor clearColor];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.diseaseList.collectionViewLayout;
    //根据设备确定item大小
    if ([UIScreen mainScreen].nativeScale == 3.0f) {

        layout.itemSize = CGSizeMake(87, 32);
        
    }else {
 
        layout.itemSize = CGSizeMake(78, 25);
    }
    
    //设置header大小
    layout.headerReferenceSize = CGSizeMake(100, 50);
    
    //注册header
    UINib *nib = [UINib nibWithNibName:@"FHChooseDiseaseHeaderView" bundle:nil];
    [self.diseaseList registerNib:nib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    
    //添加点击手势
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(itemClick)];
    [self addGestureRecognizer:gesture];
    

}

//手势点击后执行方法
- (void)itemClick {
    if ([self.delegate respondsToSelector:@selector(chooseDisease:)]) {
        [self.delegate chooseDisease:self];
    }
    
}

-(void)setDisease:(FHDiseaseModel *)disease {
    _disease = disease;

    //给cell设值
    self.diseaseList.dataSource = self;
    self.diseaseList.delegate = self;
    
    
    
}

//collectionView的数据源代理方法
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"diseaseList" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    UILabel *textLabel = [[UILabel alloc]init];
    [cell addSubview:textLabel];

    textLabel.frame = CGRectMake(0, 0, cell.width, cell.height);
    
    textLabel.textColor = [UIColor whiteColor];
    //将两侧文字向中间靠拢
    if (indexPath.item %2 !=0) {
        textLabel.textAlignment = NSTextAlignmentLeft;
    }else {
        textLabel.textAlignment = NSTextAlignmentRight;
    }
    textLabel.text = self.disease.diseaseList[indexPath.item];
   
//    cell.size = CGSizeMake(80, 20);
    if ([UIScreen mainScreen].nativeScale == 3.0f) {
        
        textLabel.font = [UIFont systemFontOfSize:16];
        
    }else {
        
        textLabel.font = [UIFont systemFontOfSize:14];
    }
    
    
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *view = nil;
    
    //添加header
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        FHChooseDiseaseHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        header.backgroundColor = [UIColor clearColor];
        [header.title setTitle:self.disease.title forState:UIControlStateNormal];
        [header.title setImage:[UIImage imageNamed:self.disease.image] forState:UIControlStateNormal];
        
        
        view = header;

        return view;
    }
    
    return nil;
    
    
}



@end

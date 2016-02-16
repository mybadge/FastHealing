//
//  FHFamilyHistoryController.m
//  FastHealing
//
//  Created by 王 on 16/1/22.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHFamilyHistoryController.h"
#import "FHFlowLayout.h"
#import "FHDiseaseBtnChosenCell.h"
#import "Masonry.h"

@interface FHFamilyHistoryController ()<diseaseBtnChosenCellDelegate>

@property (strong, nonatomic) NSArray *familyHistoryArray;
@property (assign, nonatomic) BOOL diseaseBtnSelected;
@property (assign, nonatomic) NSInteger selectedItem;
@property (assign, nonatomic) BOOL isClicked;
@property (strong, nonatomic) NSMutableArray *everyCellSelected;

@end

@implementation FHFamilyHistoryController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FHFlowLayout *layout = (FHFlowLayout *)self.collectionViewLayout;
    layout.diseases = self.familyHistoryArray;
    
    [self.collectionView registerClass:[FHDiseaseBtnChosenCell class] forCellWithReuseIdentifier:@"familyHistory"];
    
    
    //增加标题label
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"家族疾病史:";
    [self.view addSubview:titleLabel];
    
    //设置约束
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(3);
        make.left.equalTo(self.view.mas_left);
    }];

}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.familyHistoryArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FHDiseaseBtnChosenCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"familyHistory" forIndexPath:indexPath];


//    cell.backgroundColor = FHColor(240, 240, 240);

//    cell.title = [NSString stringWithFormat:@"%ld",(long)indexPath.item];

    cell.title = self.familyHistoryArray[indexPath.item];


    NSNumber *numTem = self.everyCellSelected[indexPath.item];
    cell.isSelected = numTem.boolValue;



    
    return cell;
}




-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FHDiseaseBtnChosenCell *cell = (FHDiseaseBtnChosenCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    
    self.selectedItem = indexPath.item;
    

    self.isClicked = YES;

    self.everyCellSelected[indexPath.item] = [NSNumber numberWithBool:!cell.isSelected];

    
    
    
    FHFlowLayout *layout = (FHFlowLayout *)self.collectionViewLayout;
//    layout.clickBtnTag = indexPath.item;
    layout.allItemsSelected = self.everyCellSelected;
    [self.collectionView reloadData];

//    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
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


//懒加载家族疾病史
-(NSArray *)familyHistoryArray {
    if (_familyHistoryArray == nil) {
        _familyHistoryArray = @[@"精神障碍",@"智力障碍",@"频繁流产",@"家族性先天畸形",@"死产",@"其他"];
    }
    return _familyHistoryArray;
}

-(NSMutableArray *)everyCellSelected {
    if (_everyCellSelected == nil) {
        NSMutableArray *arrTem = [NSMutableArray array];
        for (int i = 0; i < self.familyHistoryArray.count; i++) {
            BOOL btnSelected = NO;
            
            [arrTem addObject:[NSNumber numberWithBool:btnSelected]];
        }
        _everyCellSelected = arrTem;
    }
    return _everyCellSelected;
}

@end

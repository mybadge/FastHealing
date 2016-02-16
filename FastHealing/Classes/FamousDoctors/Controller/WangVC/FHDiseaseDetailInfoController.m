//
//  FHDiseaseDetailInfoController.m
//  FastHealing
//
//  Created by 王 on 16/1/24.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHDiseaseDetailInfoController.h"
#import "FHFlowLayout.h"
#import "FHDiseaseBtnChosenCell.h"
#import "Masonry.h"


@interface FHDiseaseDetailInfoController ()

@property (strong, nonatomic) NSMutableArray *diseaseDetailInfoArray;
@property (assign, nonatomic) BOOL diseaseBtnSelected;
@property (assign, nonatomic) NSInteger selectedItem;
@property (assign, nonatomic) BOOL isClicked;
@property (strong, nonatomic) NSMutableArray *everyCellSelected;
@property (strong, nonatomic) NSArray *parentArray;
@property (strong, nonatomic) NSArray *childbirthArray;
@property (strong, nonatomic) NSArray *afterChildbirthArray;
@property (strong, nonatomic) FHFlowLayout *layout;

@end

@implementation FHDiseaseDetailInfoController

static NSString * const reuseIdentifier = @"diseaseDetailInfo";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    FHFlowLayout *layout = (FHFlowLayout *)self.collectionViewLayout;
    self.layout = layout;
    layout.diseases = self.diseaseDetailInfoArray;
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    //增加标题label
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"家族疾病史:";
    [self.view addSubview:titleLabel];
    
    //设置约束
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(3);
        make.left.equalTo(self.view.mas_left);
    }];
    
    // Register cell classes
    [self.collectionView registerClass:[FHDiseaseBtnChosenCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
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


-(void)setBtnSelectedTag:(NSInteger)btnSelectedTag {
    _btnSelectedTag = btnSelectedTag;
    
    switch (btnSelectedTag) {
        case 100: {
            [self.diseaseDetailInfoArray removeAllObjects];
            [self.diseaseDetailInfoArray addObjectsFromArray:self.parentArray];
            break;
        }
        case 110: {
            [self.diseaseDetailInfoArray removeAllObjects];
            [self.diseaseDetailInfoArray addObjectsFromArray:self.childbirthArray];
            break;
        }
        case 120: {
            [self.diseaseDetailInfoArray removeAllObjects];
            [self.diseaseDetailInfoArray addObjectsFromArray:self.afterChildbirthArray];
            break;
        }
            
        default:
            break;
    }
    
//    FHFlowLayout *layout = (FHFlowLayout *)self.collectionViewLayout;
    [self.everyCellSelected removeAllObjects];
    for (int i = 0; i < self.diseaseDetailInfoArray.count; i++) {
        BOOL btnSelected = NO;
        
        [self.everyCellSelected addObject:[NSNumber numberWithBool:btnSelected]];
    }
    self.layout.diseases = self.diseaseDetailInfoArray;
    [self.collectionView reloadData];
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    [collectionView.collectionViewLayout invalidateLayout];
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    [collectionView.collectionViewLayout invalidateLayout];
    return self.diseaseDetailInfoArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FHDiseaseBtnChosenCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
//    cell.backgroundColor = FHRandomColor;
    
    cell.title = self.diseaseDetailInfoArray[indexPath.item];
    
    
    NSNumber *numTem = self.everyCellSelected[indexPath.item];
    cell.isSelected = numTem.boolValue;
    

    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FHDiseaseBtnChosenCell *cell = (FHDiseaseBtnChosenCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    
    self.selectedItem = indexPath.item;
    
    
    self.isClicked = YES;
    
    self.everyCellSelected[indexPath.item] = [NSNumber numberWithBool:!cell.isSelected];
    
    
    
    
    FHFlowLayout *layout = (FHFlowLayout *)self.collectionViewLayout;
    //    layout.clickBtnTag = indexPath.item;
    layout.allItemsSelected = self.everyCellSelected;
    [self.collectionView reloadData];

}


//懒加载
-(NSMutableArray *)diseaseDetailInfoArray {
    if (_diseaseDetailInfoArray == nil) {
        _diseaseDetailInfoArray = [NSMutableArray arrayWithArray:self.parentArray];
    }
    return _diseaseDetailInfoArray;
}

-(NSArray *)parentArray {
    if (_parentArray == nil) {
        _parentArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"parentReason.plist" ofType:nil]];
    }
    return _parentArray;
}

-(NSArray *)childbirthArray {
    if (_childbirthArray == nil) {
        _childbirthArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"childbirthReason.plist" ofType:nil]];
    }
    return _childbirthArray;
}

-(NSArray *)afterChildbirthArray {
    if (_afterChildbirthArray == nil) {
        _afterChildbirthArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"afterChildbirthReason.plist" ofType:nil]];;
    }
    return _afterChildbirthArray;

}

-(NSMutableArray *)everyCellSelected {
    if (_everyCellSelected == nil) {
        NSMutableArray *arrTem = [NSMutableArray array];
        for (int i = 0; i < self.diseaseDetailInfoArray.count; i++) {
            BOOL btnSelected = NO;
            
            [arrTem addObject:[NSNumber numberWithBool:btnSelected]];
        }
        _everyCellSelected = arrTem;
    }
    return _everyCellSelected;
}

@end

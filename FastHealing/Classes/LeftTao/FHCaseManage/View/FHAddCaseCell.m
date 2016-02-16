//
//  FHAddCaseCell.m
//  FastHealing
//
//  Created by tao on 16/1/25.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHAddCaseCell.h"


//@interface FHAddCaseCell()<UICollectionViewDelegate,UICollectionViewDataSource>
//@property (strong, nonatomic) UICollectionView *thirdCollecttionView;
//
//@end

@implementation FHAddCaseCell


+ (instancetype)loadFirstSectionCell{
    FHAddCaseCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"FHAddCaseCell" owner:nil options:nil] firstObject];
    return cell;
}

+ (instancetype)loadSecondSectionCell{
    FHAddCaseCell *cell = [[NSBundle mainBundle] loadNibNamed:@"FHAddCaseCell" owner:nil options:nil][1];
   
    
    return cell;
}
//
+ (instancetype)loadThirdSectionCell{
    FHAddCaseCell *cell = [[NSBundle mainBundle] loadNibNamed:@"FHAddCaseCell" owner:nil options:nil][2];

    return cell;
}


+ (instancetype)loadForthSectionCell{
    FHAddCaseCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"FHAddCaseCell" owner:nil options:nil] lastObject];
    return cell;
}




//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return 4;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    UICollectionViewCell *cell = [self.thirdCollecttionView dequeueReusableCellWithReuseIdentifier:@"thirdCollectionCell" forIndexPath:indexPath];
//    cell.backgroundColor = FHRandomColor;
//    return cell;
//}
//
//
//
//
//- (instancetype)initWithCoder:(NSCoder *)aDecoder{
//    if (self = [super initWithCoder:aDecoder]) {
//        if ([self.reuseIdentifier isEqualToString:@"ThirdYG" ]) {
//            [self.thirdCollecttionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"thirdCollectionCell"];
//            
//            UICollectionView *collectionView = [self viewWithTag:1113];
//            //collectionView.delegate = cell;
//            //collectionView.dataSource = cell;
//            self.thirdCollecttionView = collectionView;
//            self.thirdCollecttionView.delegate = self;
//            self.thirdCollecttionView.dataSource = self;
//            
//        }
//        
//
//    }
//    return self;
//}
//
//- (void)awakeFromNib {
//    // Initialization code
//    
//    
//}
//



@end

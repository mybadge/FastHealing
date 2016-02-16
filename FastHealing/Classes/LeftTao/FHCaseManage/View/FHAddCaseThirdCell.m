//
//  FHAddCaseThirdCell.m
//  FastHealing
//
//  Created by tao on 16/1/26.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHAddCaseThirdCell.h"



@interface FHAddCaseThirdCell()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *speLine;

//@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation FHAddCaseThirdCell





+ (instancetype)loadThirdCaseCellWith:(UITableView *)tableView{
    FHAddCaseThirdCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"FHAddCaseThirdCell" owner:nil options:nil] lastObject];
    return cell;
}

- (void)awakeFromNib {
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    
    //注册cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"bingfazhengCell"];
}

- (void)layoutSubviews{
   // self.collectionView.height =
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 9;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"bingfazhengCell" forIndexPath:indexPath];
    cell.backgroundColor = FHRandomColor;
    //cell.bounds = CGRectMake(0, 40, 40, 40);
    
    return cell;
}






- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  FHXCCollectionViewController.m
//  FastHealing
//
//  Created by xiechen on 16/1/25.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHXCCollectionViewController.h"

@interface FHXCCollectionViewController ()




@end

@implementation FHXCCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
  
    UIView *view = [[UIView alloc]initWithFrame:cell.bounds];
    
    view.backgroundColor = [UIColor redColor];
    
    cell.backgroundView = view;
    
    return cell;
}








@end

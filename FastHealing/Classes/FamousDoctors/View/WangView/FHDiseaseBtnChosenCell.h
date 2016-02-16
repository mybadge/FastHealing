//
//  FHDiseaseBtnChosenCell.h
//  FastHealing
//
//  Created by 王 on 16/1/23.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FHDiseaseBtnChosenCell;
@protocol diseaseBtnChosenCellDelegate <NSObject>
@optional
- (void)diseaseBtnChosenCell: (FHDiseaseBtnChosenCell *)chosenCell button:(UIButton *)btn;

@end
@interface FHDiseaseBtnChosenCell : UICollectionViewCell

@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) NSInteger btnTag;

@property (assign, nonatomic) BOOL isSelected;

@property (weak, nonatomic) id<diseaseBtnChosenCellDelegate> delegate;

@end

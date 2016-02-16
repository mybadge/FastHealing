//
//  FHFlowLayout.h
//  FastHealing
//
//  Created by 王 on 16/1/22.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FHFlowLayout;
@protocol flowLayoutDelegate <NSObject>

- (void)flowLayout:(FHFlowLayout *)layout maxValueY:(CGFloat)valueY layoutName:(NSString *)name;

@end

@interface FHFlowLayout : UICollectionViewFlowLayout

@property (strong, nonatomic) NSArray *diseases;
@property (assign, nonatomic) CGFloat clickBtnTag;
@property (strong, nonatomic) NSMutableArray *allItemsSelected;

@property (copy, nonatomic) NSString *layoutName;

//设置代理
@property (weak, nonatomic) id<flowLayoutDelegate> delegate;

@end

//
//  FHFlowLayout.m
//  FastHealing
//
//  Created by 王 on 16/1/22.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHFlowLayout.h"


#define itemMargin 5.0
#define imageWidth 10.0

@interface FHFlowLayout ()

@property (assign, nonatomic) CGFloat itemWInTotal;
@property (strong, nonatomic) NSMutableArray *layoutAttrArray;
@property (assign, nonatomic) BOOL addDistance;
@property (assign, nonatomic) CGFloat maxValueY;

@end

@implementation FHFlowLayout

-(void)prepareLayout {
    //准备布局

//    CGFloat itemH = 25;
//    CGFloat itemX = 0;
//    CGFloat itemY = 0;
//    CGFloat itemW = 0;
//    for (int i = 0; i < self.diseases.count; i++) {
    

//        if (self) {
//            //选中状态下计算item大小
//           self.layoutAttrArray = [self calculateEveryItemSizeWithImageWidth:imageWidth];
//        }else {
    self.itemWInTotal = 0;
    self.addDistance = NO;
    [self.layoutAttrArray removeAllObjects];
    self.layoutAttrArray = [self calculateEveryItemSizeWithImageWidth:0];
//        }
            //未选中状态下计算item大小
//            NSString *diseaseName = self.diseases[i];
//
//            NSDictionary *attr = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
//            CGRect nameFrame = [diseaseName boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
//            itemW = nameFrame.size.width + imageWidth;
//            itemX = self.itemWInTotal + itemMargin;
//            self.itemWInTotal = itemX + itemW;
//            
//            if (itemY == 0 && !self.addDistance) {
//                itemX += 100;
//                self.itemWInTotal += 100;
//                self.addDistance = YES;
//            }
//            
//            if (self.itemWInTotal > FHScreenSize.width) {
//                itemX = 0;
//                itemY = itemY + itemH + itemMargin;
//                self.itemWInTotal = itemX + itemW + itemMargin;
//            }
//            
//        }
//        
//        UICollectionViewLayoutAttributes *layoutAttr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//        layoutAttr.frame = CGRectMake(itemX, itemY, itemW, itemH);
//        [self.layoutAttrArray addObject:layoutAttr];
//        
//    }
    
//    //存储最后一个item的y值
//    self.maxValueY = itemY + itemH + itemMargin;
    
}

//计算每一个item的布局
- (NSMutableArray *)calculateEveryItemSizeWithImageWidth:(CGFloat)imageW {
    //准备布局
    NSMutableArray *arrTem = [[NSMutableArray alloc]init];
    
    CGFloat itemH = 25;
    CGFloat itemX = 0;
    CGFloat itemY = 0;
    CGFloat itemW = 0;
    for (int i = 0; i < self.diseases.count; i++) {
        
        NSString *diseaseName = self.diseases[i];
        
        NSDictionary *attr = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
        CGRect nameFrame = [diseaseName boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
        itemW = nameFrame.size.width + imageWidth + imageW;
        itemX = self.itemWInTotal + itemMargin;

        
        
        if (itemY == 0 && !self.addDistance) {
            itemX += 100;
            self.itemWInTotal += 100;
            self.addDistance = YES;
        }
     
        
        //将选中按钮的宽度改变
        NSNumber *numTem = self.allItemsSelected[i];
//        numTem.boolValue
        if (numTem.boolValue ) {
            itemW += imageWidth;
        }
   
        self.itemWInTotal = itemX + itemW;
        
        //换行的约束
        if (self.itemWInTotal > FHScreenSize.width - 20) {
            itemX = 0;
            itemY = itemY + itemH + itemMargin;
            self.itemWInTotal = itemX + itemW;
        }
        
        UICollectionViewLayoutAttributes *layoutAttr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        layoutAttr.frame = CGRectMake(itemX, itemY, itemW, itemH);
        [arrTem addObject:layoutAttr];
    }
    
    //存储最后一个item的y值
    self.maxValueY = itemY + itemH + itemMargin;
    
    return arrTem;
}




-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    //布局完成,更新约束
    if ([self.delegate respondsToSelector:@selector(flowLayout:maxValueY:layoutName:)]) {
        [self.delegate flowLayout:self maxValueY:self.maxValueY layoutName:self.layoutName];
    }
    
    return self.layoutAttrArray;
}


//-(UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
//    [self.layoutAttrArray removeAllObjects];
//    return self.layoutAttrArray[itemIndexPath.item];
//}

-(NSMutableArray *)layoutAttrArray {
    if (_layoutAttrArray == nil) {
        _layoutAttrArray = [NSMutableArray array];
    }
    return _layoutAttrArray;
}


@end

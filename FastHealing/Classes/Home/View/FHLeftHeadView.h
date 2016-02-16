//
//  FHLeftHeadView.h
//  FastHealing
//
//  Created by 赵志丹 on 16/1/19.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FHUser;

@class FHLeftHeadView;

@protocol FHLeftHeadViewDelegate <NSObject>

- (void)LeftHeadView:(FHLeftHeadView *)view didClickPIbutton:(UIButton *)sender;

@end



@interface FHLeftHeadView : UIView
@property (nonatomic, strong) FHUser *user;
+ (instancetype)leftHeadView;

@property (nonatomic, weak) id<FHLeftHeadViewDelegate> delegate;

@end

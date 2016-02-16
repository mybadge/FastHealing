//
//  FHDiseaseTypeView.h
//  FastHealing
//
//  Created by 王 on 16/1/24.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FHDiseaseTypeView;
@protocol diseaseTypeViewDelegate <NSObject>

- (void)diseaseTypeView:(FHDiseaseTypeView *)diseaseTypeView clickButton: (UIButton *)btn;

@end

@interface FHDiseaseTypeView : UIView

@property (weak, nonatomic) id<diseaseTypeViewDelegate> delegate;

@end

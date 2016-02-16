//
//  FHDoctorBtn.m
//  FastHealing
//
//  Created by xianbinniu on 16/1/24.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHDoctorBtn.h"
#import "UIView+Extension.h"

@implementation FHDoctorBtn

//调整间距和图片大小
-(void)layoutSubviews{
    [super layoutSubviews];
    CGSize path=self.titleLabel.frame.size;
    self.imageView.x=15;
    self.titleLabel.x=40;
    self.imageView.y=self.titleLabel.y;
    self.imageView.size=CGSizeMake(self.imageView.height, path.height);
    
}
@end

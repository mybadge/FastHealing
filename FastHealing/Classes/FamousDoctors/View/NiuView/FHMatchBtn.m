//
//  FHMatchBtn.m
//  FastHealing
//
//  Created by xianbinniu on 16/1/25.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHMatchBtn.h"

@implementation FHMatchBtn

//调整间距和图片大小
-(void)layoutSubviews{
    [super layoutSubviews];
    CGSize path=self.titleLabel.frame.size;
    self.imageView.size=CGSizeMake(path.height, path.height);
    self.titleLabel.x=CGRectGetMaxX(self.imageView.frame)+5;
    
}

@end

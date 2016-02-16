//
//  UITextField+Extension.m
//  FastHealing
//
//  Created by 赵志丹 on 16/1/21.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)
- (void)setLeftViewWithImageName:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    //image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImageView *leftImageView = [[UIImageView alloc] initWithImage:image];
    self.leftView = leftImageView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
//返回UITextField leftView 的bounds
- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    return CGRectMake(5, 5, 20, 20);
}
#pragma clang diagnostic pop
@end

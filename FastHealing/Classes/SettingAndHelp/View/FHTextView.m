//
//  FHTextView.m
//  FastHealing
//
//  Created by 赵志丹 on 16/1/26.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHTextView.h"

@implementation FHTextView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSLog(@"%s",__func__);
        //当UITextView的文字发生改变,UITextView 自己会发出一个UITextViewTextDidChangeNotification通知
        [FHNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)awakeFromNib {
    NSLog(@"%s",__func__);
    [FHNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];

}

//- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder {
//    
//    NSLog(@"%s",__func__);
//    self = [super awakeAfterUsingCoder:aDecoder];
//    if (self) {
//               }
//    return self;
//}

- (void)dealloc{
    [FHNotificationCenter removeObserver:self];
}

- (void)textDidChange{
    //重绘
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    // 如果有输入文字，就直接返回，不画占位文字
    if (self.hasText) return;
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor ? self.placeholderColor : [UIColor grayColor];
    CGFloat x = 5;
    CGFloat y = 8;
    CGFloat w = rect.size.width - 2 * x;
    CGFloat h = rect.size.height - 2 * y;
    CGRect placeholderRect = CGRectMake(x, y, w, h);
    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
}

- (void)setText:(NSString *)text{
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font{
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}
@end

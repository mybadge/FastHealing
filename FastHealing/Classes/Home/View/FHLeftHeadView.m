//
//  FHLeftHeadView.m
//  FastHealing
//
//  Created by 赵志丹 on 16/1/19.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHLeftHeadView.h"
#import "FHUser.h"
#import "UIImageView+WebCache.h"

#import "FHPersonaViewController.h"

@interface FHLeftHeadView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation FHLeftHeadView
- (IBAction)btnClick:(UIButton *)sender {
    //todo 界面跳转
    if ([self.delegate respondsToSelector:@selector(LeftHeadView:didClickPIbutton:)]) {
        [self.delegate LeftHeadView:self didClickPIbutton:sender];
    }
}


- (void)setUser:(FHUser *)user {
    _user = user;
    
    self.titleLabel.text = user.true_name;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.user.head_photo] placeholderImage:[UIImage imageNamed:@"02"]];
}
- (void)awakeFromNib {
    self.iconView.layer.cornerRadius = 30;
    self.iconView.layer.masksToBounds = YES;
    self.backgroundColor = FHThemeColor;
}
+ (instancetype)leftHeadView {
    return [[[NSBundle mainBundle] loadNibNamed:@"FHLeftHeadView" owner:nil options:nil] lastObject];
}




@end

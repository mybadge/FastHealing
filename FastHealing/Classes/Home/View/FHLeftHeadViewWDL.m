//
//  FHLeftHeadViewWDL.m
//  FastHealing
//
//  Created by 赵志丹 on 16/1/21.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHLeftHeadViewWDL.h"

@interface FHLeftHeadViewWDL ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerViewConstraint;

@end
@implementation FHLeftHeadViewWDL
- (IBAction)registerClick {
    if (self.btnClickBlock) {
        self.btnClickBlock(@"register");
    }
}
- (IBAction)loginClick {
    if (self.btnClickBlock) {
        self.btnClickBlock(@"login");
    }
}

+ (instancetype)leftHeadViewWDL {
    return [[[NSBundle mainBundle] loadNibNamed:@"FHLeftHeadViewWDL" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    self.iconView.layer.cornerRadius = 30;
    self.iconView.layer.masksToBounds = YES;
    //self.centerViewConstraint.constant = -FHSideMenuOffset * 0.35;
    self.backgroundColor = FHThemeColor;
    self.iconView.backgroundColor = FHThemeColor;
    
}
@end

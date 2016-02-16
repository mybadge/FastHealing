//
//  FHPersonHeaderDetail.h
//  FastHealing
//
//  Created by 赫腾飞 on 16/1/25.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "FHUser.h"

@interface FHPersonHeaderDetail : UIView

//@property (nonatomic, weak) UIView *headerView;//头像行
@property (nonatomic, weak) UIImageView *header;//头像
@property (nonatomic, weak) UIImageView *personGender;//性别Image

@property (nonatomic, strong) FHUser *user;

@end

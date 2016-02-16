//
//  FHPictureBy.h
//  FastHealing
//
//  Created by xiechen on 16/1/24.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^MyblockPicture)(UIWebView *);

@interface FHPictureBy : UIView
@property (nonatomic,strong)NSArray *pictures;

@property (nonatomic,copy)MyblockPicture pictureBlock;

@end

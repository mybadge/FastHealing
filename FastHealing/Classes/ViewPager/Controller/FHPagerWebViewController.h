//
//  FHPagerWebViewController.h
//  FastHealing
//
//  Created by 赫腾飞 on 16/1/21.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FHPagerWebViewController : UIViewController

//跳转网页 传入URLString
@property (nonatomic, copy) NSString *URLString;

@property (nonatomic, copy) NSString *html;
@end

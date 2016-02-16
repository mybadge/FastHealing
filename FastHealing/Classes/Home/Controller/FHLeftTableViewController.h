//
//  FHLeftTableViewController.h
//  FastHealingD
//
//  Created by 赫腾飞 on 16/1/19.
//  Copyright © 2016年 hetefe. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^DidSelectedVcBlock)(UIViewController *);
@interface FHLeftTableViewController : UITableViewController
@property (nonatomic, copy) DidSelectedVcBlock didSelectedVcBlock;
@end

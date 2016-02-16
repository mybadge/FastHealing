//
//  FHChangeBigCaseTC.h
//  FastHealing
//
//  Created by tao on 16/1/26.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FHChangeBigCaseModel;
typedef void(^ChangeBigCaseBlock)(FHChangeBigCaseModel *model);


@interface FHChangeBigCaseTC : UITableViewController

@property (copy, nonatomic) ChangeBigCaseBlock changeBlock;


@end

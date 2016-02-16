//
//  FHSalvageBasicInfoController.h
//  FastHealing
//
//  Created by 王 on 16/1/21.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol salvageBasicInfoDelegate <NSObject>

- (void)chooseRelationshipOrRegion:(NSString *)chosenTitle;

@end


@interface FHSalvageBasicInfoController : UIViewController

@property (strong, nonatomic) NSString *diseaseTitle;
@property (strong, nonatomic) NSString *diseaseName;

@property (weak, nonatomic) id<salvageBasicInfoDelegate> delegate;

@end

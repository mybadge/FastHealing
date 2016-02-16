//
//  FHUserViewModel.h
//  FastHealing
//
//  Created by 赵志丹 on 16/1/21.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FHUser.h"

typedef void (^LoginBlock)(FHUser *user, NSString *result);

@interface FHUserViewModel : NSObject
@property (nonatomic, strong) FHUser *user;
@property (nonatomic, assign, getter=isLogin) BOOL login;

+ (instancetype)shareUserModel;

- (void)loginDataWithBlock:(NSMutableDictionary *)params loginBlock:(LoginBlock)loginBlock;

- (void)logout;
@end


//
//  FHMessageAuthenticationTool.h
//  FastHealing
//
//  Created by xiechen on 16/1/21.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Block)();

@interface FHMessageAuthenticationTool : NSObject

+ (instancetype)shareMessageAuthentication;

- (void)getMessageAuthenticationAccountField:(NSString *)account;

- (void)myCommitVerificationCodePwdText:(NSString *)pwd andAccountField:(NSString *)account myBlock:(Block )myBlock;


@end

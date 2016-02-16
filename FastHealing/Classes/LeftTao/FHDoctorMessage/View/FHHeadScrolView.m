//
//  FHHeadScrolView.m
//  FastHealing
//
//  Created by tao on 16/1/23.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHHeadScrolView.h"

@interface FHHeadScrolView()
@property (weak, nonatomic) IBOutlet UIButton *receiveBtn;
@property (weak, nonatomic) IBOutlet UIButton *introduceBtn;

@property (weak, nonatomic) IBOutlet UIView *scrolView;
@end



@implementation FHHeadScrolView


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (IBAction)receiveBtnClick:(UIButton *)btn{
    //NSLog(@"oooo点解了receive");
    
    if (self.scrollViewChangeBlock) {
        self.scrollViewChangeBlock(NO);
    }
    
    
}

- (IBAction)introduceBtnClick:(UIButton *)btn{
    
    if (self.scrollViewChangeBlock) {
        self.scrollViewChangeBlock(YES);
    }
    
}

@end

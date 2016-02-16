//
//  HTFPopupWindow.h
//  PopupWindow
//
//  Created by 赫腾飞 on 16/1/24.
//  Copyright © 2016年 hetefe. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^VlaueBlack)(NSInteger str);

@interface HTFPopupWindow : UIView

//@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIView *middleView;
@property (nonatomic, strong) UILabel *titleLable;//标题
- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic, copy)VlaueBlack valueblock;

@end

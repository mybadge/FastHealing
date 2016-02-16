//
//  FHSelectRefreshControl.m
//  FastHealing
//
//  Created by ZhangZiang on 16/1/22.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHSelectRefreshControl.h"
#import "Masonry.h"

typedef enum : NSUInteger {
    RefreshDrag,
    Refreshing,
    RefreshBack,
} RefreshStatus;

@interface FHSelectRefreshControl ()

@property (nonatomic, weak) UIImageView *refreshImageView;

@property (nonatomic, weak) UILabel *infoLabel;

@property (nonatomic, strong) UIScrollView *scrollSuper;

@property (nonatomic, assign) RefreshStatus refreshState;

@end

@implementation FHSelectRefreshControl

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor whiteColor];
    
    UIImageView *refreshImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tableview_pull_refresh"]];
    
    self.refreshImageView = refreshImageView;
    
    [self addSubview:refreshImageView];
    
    UILabel *infoLabel = [[UILabel alloc]init];
    
    infoLabel.text = @"下拉加载更多";
    infoLabel.font = [UIFont systemFontOfSize:15];
    
    self.infoLabel = infoLabel;
    
    [self addSubview:infoLabel];
    

}

- (void)setRefreshState:(RefreshStatus)refreshState {
    _refreshState = refreshState;
    
    CGFloat refreshHeight = 44;
    
    switch (refreshState) {
        case RefreshDrag: {
            self.refreshImageView.image = [UIImage imageNamed:@"tableview_pull_refresh"];
            [UIView animateWithDuration:0.5 animations:^{
                self.refreshImageView.transform = CGAffineTransformIdentity;
            }];
            self.infoLabel.text = @"下拉加载更多";}
            break;
        case Refreshing: {
            self.refreshImageView.image = [UIImage imageNamed:@"tableview_loading"];
            self.infoLabel.text = @"正在努力加载...";
            CABasicAnimation *basicAn = [[CABasicAnimation alloc]init];
            basicAn.keyPath = @"transform.rotation";
            basicAn.byValue = @(2*M_PI);
            basicAn.duration = 1;
            basicAn.repeatCount = INT_MAX;
            [self.refreshImageView.layer addAnimation:basicAn forKey:nil];
            [UIView animateWithDuration:1 animations:^{
                UIEdgeInsets inset = self.scrollSuper.contentInset;
                inset.top += refreshHeight;
                self.scrollSuper.contentInset = inset;
            }];
            
            [self sendActionsForControlEvents:UIControlEventValueChanged];
       
        }
            break;
        case RefreshBack: {
            self.refreshImageView.image = [UIImage imageNamed:@"tableview_pull_refresh"];
            [UIView animateWithDuration:0.5 animations:^{
                self.refreshImageView.transform = CGAffineTransformMakeRotation(M_PI);
            }];
            
            self.infoLabel.text = @"松开刷新";}
            break;
            
        default:
            break;
    }
}

- (void)endRefresh {
    self.refreshState = RefreshDrag;
    
    CGFloat refreshHeight = 44;
    
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = self.scrollSuper.contentInset;
        inset.top -= refreshHeight;
        self.scrollSuper.contentInset = inset;
    }];

    [self.refreshImageView.layer removeAllAnimations];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    UIScrollView *scroll = (UIScrollView *)newSuperview;
    
    [scroll addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    self.scrollSuper = scroll;
}

- (void)dealloc {
    [self.scrollSuper removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
//    NSLog(@"%f",self.scrollSuper.contentOffset.y+64);
    CGFloat offsetValue = - (self.scrollSuper.contentOffset.y+64);
    
    if (self.scrollSuper.dragging) {
        if (offsetValue > 44) {
            self.refreshState = RefreshBack;
        } else if (offsetValue < 44 && self.refreshState == RefreshBack) {
            self.refreshState = RefreshDrag;
        }
    }
    else {
        if (self.refreshState == RefreshBack) {
            self.refreshState = Refreshing;
        }
    }
    

}



- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.refreshImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self).offset(-50);
    }];
    
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.refreshImageView.mas_right);
    }];
}


@end

//
//  FHPictureBy.m
//  FastHealing
//
//  Created by xiechen on 16/1/24.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#define myScreen [UIScreen mainScreen].bounds.size

#import "FHPictureBy.h"
#import "Masonry.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "FHNetworkTools.h"
#import "FHPictureModel.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"
#import "FHPictureByController.h"

@interface FHPictureBy ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIPageControl *page;
@property (nonatomic,assign)NSInteger index;
@property (nonatomic,strong)AFHTTPSessionManager *sessinManage;
@property (nonatomic,strong)NSTimer *timer;


@end
static int i = 0;
@implementation FHPictureBy


-(void)setPictures:(NSArray *)pictures{
    _pictures = pictures;
    
    UIScrollView *scroollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    scroollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * pictures.count + 1, scroollView.height);
    //隐藏指示条
    scroollView.showsHorizontalScrollIndicator = NO;
    //开启分页效果
    scroollView.pagingEnabled = YES;
    scroollView.showsVerticalScrollIndicator = NO;
    scroollView.delegate = self;
    self.scrollView = scroollView;
    
    UIPageControl *page = [[UIPageControl alloc]initWithFrame:CGRectMake(myScreen.width / 2 - 40, scroollView.height, 80, 28)];
    page.y = CGRectGetMaxY(scroollView.frame) - 28;
    page.numberOfPages = pictures.count;
    page.currentPageIndicatorTintColor = [UIColor blackColor];
    page.pageIndicatorTintColor = [UIColor grayColor];
    self.page = page;
    [page addTarget:self action:@selector(pageChange) forControlEvents:UIControlEventEditingChanged];
    
    CGFloat y = 0;
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = self.height;
    NSInteger imageCount = pictures.count;
    for (int i = 0; i < imageCount + 1; i++) {
        
        
        CGFloat x = [UIScreen mainScreen].bounds.size.width * i;
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(x, y, w, h);
        if (imageCount - 1 < i) {
            FHPictureModel *model = pictures[0];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.banner_img_url] placeholderImage:[UIImage imageNamed:@"wea"]];
        }else{
            FHPictureModel *model = pictures[i];
            self.index = i;
            NSLog(@"%@",model.banner_link);
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.banner_img_url] placeholderImage:[UIImage imageNamed:@"wea"]];
        }
        
        [scroollView addSubview:imageView];
    }
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [scroollView addGestureRecognizer:tapGesture];
    [self addSubview:scroollView];
    [self addSubview:page];
    
    [self addTimer];
}

- (void)tapClick:(NSInteger)index{
    
    int a = self.scrollView.contentOffset.x / myScreen.width;
    
    FHPictureModel *model = self.pictures[a];
    NSLog(@"%@",model.banner_link);
    UIWebView *web = [[UIWebView alloc]init];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:model.banner_link]];
    web.scalesPageToFit = YES;
    [web loadRequest:request];
    
    if (_pictureBlock) {
        _pictureBlock(web);
    }
}
//将要开始拖拽的时候调用
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self removieTimer];
}
//结束拖拽的时候
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}

- (void)addTimer{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.1 target:self selector:@selector(myTtimer) userInfo:nil repeats:YES];
}

- (void)removieTimer{
    [self.timer invalidate];
}

- (void)myTtimer{
    
    [self pageChange];
}

- (void)pageChange{
    
    self.page.currentPage = i;
    
    if (self.pictures.count + 1 == i) {

        self.page.currentPage = 0;
        i = 0;
        return;
    }
    if (self.pictures.count == 0) {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        return;
    }
    [UIView animateWithDuration:1.0 animations:^{
        [self.scrollView setContentOffset:CGPointMake(myScreen.width * i, 0) animated:NO];
    }];
    i++;
}

@end

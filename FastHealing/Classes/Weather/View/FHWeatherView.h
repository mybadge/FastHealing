//
//  FHWeatherView.h
//  FastHealing
//
//  Created by 赫腾飞 on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FHWeatherPositionViewController.h"
#import "UIImageView+WebCache.h"
#import "FHWeather_data.h"

typedef void(^WeatherDetail)();
@class FHWeatherView;
@protocol  FHWeatherViewDelegate <NSObject>

- (void)ClickPositionButton:(FHWeatherView *)weatherView;

@end

@interface FHWeatherView : UIView 

//Delegate property
@property (nonatomic, weak) id <FHWeatherViewDelegate> delegate;

//temperature Lable
@property (nonatomic, strong) UILabel *tempLable;

//weather Picture
@property (nonatomic, strong) UIImageView *weatherPicture;

//weather Lable
@property (nonatomic, strong) UIButton *weatherLable;

//position button
@property (nonatomic, strong) UIButton *positionButton;

@property (nonatomic, copy)WeatherDetail weatherDetail;

@property (nonatomic, strong)  FHWeather_data *data;


@end

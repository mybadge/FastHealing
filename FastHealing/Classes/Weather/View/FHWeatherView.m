//
//  FHWeatherView.m
//  FastHealing
//
//  Created by 赫腾飞 on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHWeatherView.h"

#import "UIView+Extension.h"

#import "Masonry.h"




@interface FHWeatherView ()

//separateView
@property (nonatomic, weak) UIView *separateView;
//底部视图
@property (nonatomic, weak) UIView *botomView;

@end

@implementation FHWeatherView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
    
        [self setupUI];
        //设置背景色
        self.backgroundColor = [UIColor lightGrayColor];
        
    }
    
    return self;
}

#pragma mark 添加子视图View
- (void)setupUI{
    //添加子View 设置约束
    [self creatSeparateView];
    [self.separateView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(self.height * 0.1);
        make.width.offset(1);
        make.height.offset(self.height * 0.8);
        
    }];
    
    [self.tempLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.mas_centerY);
//        make.left.equalTo(self.separateView.mas_right).offset(25);
//        make.right.equalTo(self.mas_right).offset(-25);
        make.centerX.equalTo(self.mas_centerX).offset(self.width / 4.0);
        make.width.offset(120);
        
        
    }];
    
    [self.weatherPicture mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.mas_centerY);
       
        make.top.equalTo(self.mas_top).offset(8);
        make.bottom.equalTo(self.mas_bottom).offset(-8);
        make.width.equalTo(self.weatherPicture.mas_height);
        make.left.equalTo(self.mas_left).offset(8);
//        make.width.offset(42);
//        make.height.offset(30);
        
    }];
    
    [self.weatherLable mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.weatherPicture.mas_right).offset(8);
        make.centerY.equalTo(self.weatherPicture.mas_centerY);
//        make.width.offset(50);
//        make.top.equalTo(self.mas_top);
//        make.bottom.equalTo(self.mas_bottom);
//        make.right.equalTo(self.)
    }];
    
    [self.positionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.separateView.mas_left).offset(-8);
        make.centerY.equalTo(self.weatherPicture.mas_centerY);
        make.left.equalTo(self.weatherLable.mas_right).offset(8);
        make.width.multipliedBy(1).equalTo(self.weatherLable);
        
    }];
    
    [self.positionButton addTarget:self action:@selector(didClickPositionButton) forControlEvents:UIControlEventTouchUpInside];
    [self.weatherLable addTarget:self action:@selector(didClickWeatherLable) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)didClickWeatherLable{
    
    if (self.weatherDetail) {
        self.weatherDetail();
    }
}

- (void)didClickPositionButton{

    if ([self.delegate respondsToSelector:@selector(ClickPositionButton:)]) {
        [self.delegate ClickPositionButton:self];
    }
}
//分割线
- (void)creatSeparateView{
    
    UIView *bottomView = [[UIView alloc] initWithFrame:self.bounds];
    self.botomView = bottomView;
    [self addSubview:bottomView];
    
    //添加分割线
    UIView *sepView = [[UIView alloc] init];
    sepView.backgroundColor = [UIColor blackColor];
    sepView.alpha = 0.2;
    self.separateView = sepView;
    [self.botomView addSubview:self.separateView];
    
    //添加 温度Lable
    [self.botomView addSubview:self.tempLable];
    
    //添加 天气图片
    [self.botomView addSubview:self.weatherPicture];
    
    //添加天气Lable
    [self.botomView addSubview:self.weatherLable];
    
    //添加地理UIButton
    [self.botomView addSubview:self.positionButton];
    
}


#pragma mark 子视图懒加载

-(UILabel *)tempLable{
    if (_tempLable == nil) {
        //添加 温度Lable
        _tempLable = [[UILabel alloc] init];
        [_tempLable setFont:[UIFont systemFontOfSize:17]];
        _tempLable.numberOfLines = 0;
        _tempLable.textAlignment = NSTextAlignmentCenter;
        
        _tempLable.text = @"周二 01月19日 (-5℃)";
        
    }
    return _tempLable;
}
- (UIImageView *)weatherPicture{
    if (_weatherPicture == nil) {
        _weatherPicture = [[UIImageView alloc] init];
        _weatherPicture.image = [UIImage imageNamed:@"00"];
        _weatherPicture.layer.cornerRadius = (self.height - 16) * 0.5;
        _weatherPicture.layer.masksToBounds = NO;
        //为weatherPicture添加手势
//        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClickWeatherPicture)];
//        [_weatherPicture addGestureRecognizer:gesture];
    }
    return _weatherPicture;
}
- (UIButton *)weatherLable{

    if (_weatherLable == nil) {
        _weatherLable = [[UIButton alloc] init];
        [_weatherLable.titleLabel setNumberOfLines:0];
         [_weatherLable.titleLabel setFont:[UIFont systemFontOfSize:17.0]];
        [_weatherLable setTitle:@"晴" forState:UIControlStateNormal];
       
        _weatherLable.titleLabel.adjustsFontSizeToFitWidth = YES;
        _weatherLable.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_weatherLable setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    return _weatherLable;
}
- (UIButton *)positionButton{
    
    if (_positionButton == nil) {
        _positionButton = [[UIButton alloc] init];
        _positionButton.titleLabel.numberOfLines = 0;
        [_positionButton.titleLabel setFont:[UIFont systemFontOfSize:17.0]];
        _positionButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        _positionButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_positionButton setTitle:@"北京" forState:UIControlStateNormal];
        [_positionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _positionButton;
}

- (void)setData:(FHWeather_data *)data{

    _data = data;
    if (data != nil) {
        
        NSString *weatherPictureStr = nil;
        
       weatherPictureStr = [self getRightWeatherPictureName:data.weather];
        
        if (weatherPictureStr == nil) {
            [self.weatherPicture sd_setImageWithURL: [NSURL URLWithString:data.dayPictureUrl] placeholderImage:[UIImage imageNamed: @"mai"]];
        }else{
            self.weatherPicture.image = [UIImage imageNamed:weatherPictureStr];
        }
        [self.weatherLable setTitle:data.weather forState:UIControlStateNormal];//.text = data.weather;
        self.tempLable.text = data.date;
    }else{
        //self.weatherView.weatherLable.text = @"未知";
    }  
    
}
#pragma mark 获取对应天气图片Name
- (NSString *)getRightWeatherPictureName:(NSString *)weather{
    //weather = 多云,
    //switch 判断 返回天气图片 String
    NSDate * senddate=[NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"HH"];
    
      NSString * locationString=[dateformatter stringFromDate:senddate];
    int time = [locationString intValue];
    
    if ( time >= 18) {
        
    }
    
    NSString *wea = @"";
    
    NSRange range = NSMakeRange(1, 1);
    
    if ([weather containsString:@"转"]) {
        
        range = [weather rangeOfString:@"转"];
        
        NSString *weaday = [weather substringToIndex:(range.location)];
        
        NSString *weanight = [weather substringFromIndex:(range.location + 1)];
        
        NSLog(@"%@--%@",weaday,weanight);
        wea = weaday;
        
    }else{
    
        wea = weather;
    
    }

    NSArray *weaPic = [NSArray arrayWithObjects:
                       @"晴" ,@"多云",@"阴",@"阵雨",@"雷阵雨",
                       @"雷阵雨伴有冰雹",@"雨夹雪",@"小雨",@"中雨 ",@"大雨",
                       @"暴雨",@"大暴雨",@"特大暴雨",
                       @"阵雪",@"小雪",@"中雪",@"大雪",@"暴雪",
                       @"雾",@"冻雨",@"沙尘暴",
                       @"小到中雨",@"中到大雨",@"大到暴雨",@"暴雨到大暴雨",@"大暴雨到特大暴雨",
                       @"霾",@"轻度霾",@"中度霾",@"特强霾",@"飑线",@"沙尘暴",@"霰",
                       nil];
    
    NSInteger index = [weaPic indexOfObject:wea];

    switch (index) {
            
        case 0:
             return @"00";
            break;
        case 1:
            return @"01";
            break;
        case 2:
            return @"02";
            break;
        case 3:
            return @"03";
            break;
        case 4:
            return @"04";
            break;
        case 5:
            return @"05";
            break;
        case 6:
            return @"06";
            break;
        case 7:
            return nil;
            break;
        case 8:
            return @"08";
            break;
        case 9:
            return @"09";
            break;
        case 10:
            return @"10";
            break;
        case 11:
            return @"11";
            break;
        case 12:
            return @"12";
            break;
        case 13:
            return @"13";
            break;
        case 14:
            return @"14";
            break;
        case 15:
            return @"15";
            break;
        case 16:
            return @"16";
            break;
        case 17:
            return @"17";
            break;
        case 18:
            return @"18";
            break;
        case 19:
            return @"19";
            break;
        case 20:
            return @"20";
            break;
        case 21:
            return @"21";
            break;
        case 22:
            return @"22";
            break;
        case 23:
            return @"23";
            break;
        case 24:
            return @"24";
            break;
        case 25:
            return @"25";
            break;
        case 26:
            return @"26";
            break;
        case 27:
            return @"27";
            break;
        case 28:
            return @"28";
            break;
        case 29:
            return @"30";
            break;
        case 30:
            return @"31";
            break;
        case 31:
            return @"53";
            break;
       
        default:
            return @"00";
            break;
    }
    
    return nil;
}


@end

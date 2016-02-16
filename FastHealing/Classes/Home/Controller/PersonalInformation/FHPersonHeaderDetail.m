//
//  FHPersonHeaderDetail.m
//  FastHealing
//
//  Created by 赫腾飞 on 16/1/25.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHPersonHeaderDetail.h"
#define HEIGTH_WITHOUT_BAR (FHScreenSize.height - CGRectGetMaxY(self.navigationController.navigationBar.frame))
#define HEADER_HEIGHT_SCALE 1/6.0
#define MIDDLE_HEIGHT_SCALE 1/4.0

@interface FHPersonHeaderDetail ()


@property (nonatomic, strong) UILabel *personLable;
@property (nonatomic, strong) UIImageView *idcard;
@property (nonatomic, strong) UILabel *idcardLable;

@property (nonatomic, strong) UIImageView *phone;

@property (nonatomic, strong) UILabel *phoneLable;

@end


@implementation FHPersonHeaderDetail

- (void)layoutSubviews{

    [super layoutSubviews];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)awakeAfterUsingCoder:(NSCoder *)aDecoder{
    self = [super awakeAfterUsingCoder:aDecoder];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{

    [self addSubview:self.header];
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).offset(10);
        
        make.left.equalTo(self.mas_left).offset(10);
        
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        
        make.width.multipliedBy(1).equalTo(self.header.mas_height);
        
    }];
    
   
    //性别
    [self addSubview:self.personGender];
    [self.personGender mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.header.mas_top);
        
        make.left.equalTo(self.header.mas_right).offset(10);
        
        make.width.multipliedBy(1).equalTo(self.personGender.mas_height);
        
    }];
    
    [self addSubview:self.personLable];
    [self.personLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.personGender.mas_right).offset(10);
        
        make.centerY.equalTo(self.personGender.mas_centerY);
        
        make.right.equalTo(self.mas_right).offset(-20);
        
        make.height.equalTo(self.personGender.mas_height);
        
    }];

    [self addSubview:self.idcard];
    [self.idcard mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.personGender.mas_bottom).offset(10);
        
        make.left.equalTo(self.header.mas_right).offset(10);
        
        make.width.multipliedBy(1).equalTo(self.personGender.mas_height);
        
        make.height.multipliedBy(1).equalTo(self.personGender.mas_height);
        
        
    }];
    
    [self addSubview:self.idcardLable ];
    
    [self.idcardLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.idcard.mas_right).offset(10);
        
        make.centerY.equalTo(self.idcard.mas_centerY);
        
        make.right.equalTo(self.mas_right).offset(-20);
        
        make.height.equalTo(self.personGender.mas_height);
    }];

        [self addSubview:self.phone];
    [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.idcard.mas_bottom).offset(10);
        
        make.left.equalTo(self.header.mas_right).offset(10);
        
        make.height.multipliedBy(1).equalTo(self.personGender.mas_height);
        
        make.width.multipliedBy(1).equalTo(self.personGender.mas_height);
        
        make.bottom.equalTo(self.header.mas_bottom);
        
    }];

    [self addSubview:self.phoneLable];
    [self.phoneLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.phone.mas_right).offset(10);
        
        make.centerY.equalTo(self.phone.mas_centerY);
        
        make.right.equalTo(self.mas_right).offset(-20);
        
        make.height.equalTo(self.personGender.mas_height);
        
    }];
    
}

#pragma mark 自定义创建 UIimageView  和 UIlable
- (UIImageView *)creatImageViewWithImageName:(NSString *)imageName andAddedView:(UIView *)view{
    
    UIImageView *imageView = [[UIImageView alloc] init];
    
    imageView.image = [UIImage imageNamed:imageName];
    
    [view addSubview:imageView];
    
    return imageView;
}

- (UILabel *)creatLableText:(NSString *)text withFont:(CGFloat)size addedView:(UIView *)view {
    
    UILabel *lable = [[UILabel alloc] init];
    lable.text = text;
    lable.font = [UIFont systemFontOfSize:size];
    [view addSubview:lable];
    return lable;
}

//UILabel *personLable = [self creatLableText:self.user.true_name ? self.user.true_name  : @"XXX" withFont:13.0 addedView:self];

- (UILabel *)phoneLable{

    if (_phoneLable == nil) {
         _phoneLable = [self creatLableText:self.user.mobile_number ? self.user.mobile_number : @"1**********" withFont:13.0 addedView:self];
    }
    return _phoneLable;

}

- (UIImageView *)phone{
    
    if (_phone == nil) {
        _phone = [self creatImageViewWithImageName:@"shouji" andAddedView:self];
    }
    return _phone;

}

- (UILabel *)idcardLable{
 
    if (_idcardLable == nil) {
        
         _idcardLable =  [self creatLableText:self.user.card_number ? self.user.card_number  : @"XXXXXX********XXXX"  withFont:13.0 addedView:self];
    }
    return _idcardLable;
}

- (UIImageView *)idcard{
    
    if (_idcard == nil) {
        _idcard = [self creatImageViewWithImageName:@"login_idcard" andAddedView:self];
    }
    return _idcard;
}

- (UILabel *)personLable{

    if (_personLable == nil) {
       _personLable = [self creatLableText:self.user.true_name ? self.user.true_name  : @"XXX" withFont:13.0 addedView:self];
    }
    return _personLable;
    
}
- (UIImageView *)header{
    
    if (_header == nil) {
        _header = [self creatImageViewWithImageName:@"doctor_default" andAddedView:self];
        _header.layer.cornerRadius = (self.height - 20) * 0.5;
        _header.layer.masksToBounds = NO;
    }
    return _header;
}

- (UIImageView *)personGender{
    
    if (_personGender == nil) {
        NSString *gender = @"login_boy";
        _personGender = [self creatImageViewWithImageName: gender andAddedView:self];
    }
    return _personGender;
}

- (void)setUser:(FHUser *)user{
    
    _user = user;
      [self.header sd_setImageWithURL:[NSURL URLWithString:self.user.head_photo] placeholderImage:[UIImage imageNamed:@"doctor_default"]];
    self.personLable.text = user.true_name;
    self.idcardLable.text = user.card_number;
    self.phoneLable.text = user.mobile_number;
    
    NSString *gender = @"login_boy";
    if ([_user.gender isEqualToString:@"1"]) {
    }else if ([_user.gender isEqualToString:@"0"]){
        gender = @"login_girl";
    }else{
    }
    self.personGender.image = [UIImage imageNamed:gender];
}

@end

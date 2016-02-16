//
//  FHMatchDoctorsCell.m
//  FastHealing
//
//  Created by xianbinniu on 16/1/21.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHMatchDoctorsCell.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
@interface FHMatchDoctorsCell ()
//头像
@property(nonatomic,weak) UIImageView *iconView;
//名字
@property(nonatomic,weak) UILabel *nameLable;
//职称
@property(nonatomic,weak) UILabel *ProfessLable;
//医院
@property(nonatomic,weak) UILabel *Hospital;
//预约量
@property(nonatomic,weak) UIButton *appointBtn;
//鲜花数量
@property(nonatomic,weak) UIButton *flowerBtn;
//锦旗量
@property(nonatomic,weak) UIButton *BannerBtn;
//匹配度;
@property(nonatomic,weak) UIButton *MatchBtn;
//checkMark
@property(nonatomic,weak) UIImageView *CheckMark;
//匹配率
@property(nonatomic,weak) UILabel *MatchLable;
//分割线
@property(nonatomic,weak) UIView *LineView;
@end

@implementation FHMatchDoctorsCell

/// 快速创建cell
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"cell";
    FHMatchDoctorsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[FHMatchDoctorsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
// 重写initWithStyle:方法
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]
    ;
    if (self) {
        [self addchildView];
//        self.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return self;
}
-(void)addchildView{
    
    UIImageView *iconView= [[UIImageView alloc]init];
    self.iconView = iconView;
    self.iconView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.iconView.layer.cornerRadius = 30;
    self.iconView.layer.masksToBounds = YES;
    [self.contentView addSubview:iconView];
    
    UILabel *nameLable = [[UILabel alloc]init];
    [nameLable setFont:[UIFont systemFontOfSize:17]];
    self.nameLable = nameLable;
    [self.contentView addSubview:nameLable];
    
    UILabel *ProfessLable = [[UILabel alloc]init];
    self.ProfessLable = ProfessLable;
    [ProfessLable setFont:[UIFont systemFontOfSize:16]];
    ProfessLable.textColor = FHColor(120, 120, 120);
    [self.contentView addSubview:ProfessLable];
    
    UILabel *Hospital = [[UILabel alloc]init];
    self.Hospital = Hospital;
       [Hospital setFont:[UIFont systemFontOfSize:15]];
    Hospital.textColor = FHColor(200, 200, 200);
    [self.contentView addSubview:Hospital];
    
    UIButton *appointBtn = [[UIButton alloc]init];
    appointBtn.enabled=NO;
    [appointBtn setImage:[UIImage imageNamed:@"adjunction"] forState:UIControlStateNormal];
    appointBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
//    appointBtn.backgroundColor=FHRandomColor;
    self.appointBtn = appointBtn;
    [self.contentView addSubview:appointBtn];
    [appointBtn setTitleColor:FHColor(200, 200, 200) forState:UIControlStateNormal];
    
    UIButton *flowerBtn = [[UIButton alloc]init];
    flowerBtn.enabled=NO;
//    flowerBtn.backgroundColor=FHRandomColor;
    self.flowerBtn = flowerBtn;
    [self.contentView addSubview:flowerBtn];
    [flowerBtn setImage:[UIImage imageNamed:@"discuss"] forState:
     UIControlStateNormal];
    flowerBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    [flowerBtn setTitleColor:FHColor(200, 200, 200) forState:UIControlStateNormal];
    
    UIButton *BannerBtn = [[UIButton alloc]init];
    BannerBtn.enabled=NO;
    [BannerBtn setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
//    BannerBtn.imageView.backgroundColor=[UIColor redColor];
//     BannerBtn.titleLabel.backgroundColor=[UIColor blueColor];
    BannerBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
//    BannerBtn.backgroundColor=FHRandomColor;
    self.BannerBtn = BannerBtn;
    [self.contentView addSubview:BannerBtn];
    [BannerBtn setTitleColor:FHColor(200, 200, 200) forState:UIControlStateNormal];
    
    UIButton *MatchBtn = [[UIButton alloc]init];
    MatchBtn.enabled=NO;
//    MatchBtn.backgroundColor=FHRandomColor;
    self.MatchBtn = MatchBtn;
    [self.contentView addSubview:MatchBtn];
    MatchBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [MatchBtn setBackgroundImage:[UIImage imageNamed:@"gongyi_qi"] forState:UIControlStateNormal];
    [MatchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UILabel *MatchLable=[[UILabel alloc]init];
    MatchLable.textColor=[UIColor whiteColor];
    MatchLable.font = [UIFont systemFontOfSize:14];
    MatchLable.textAlignment = NSTextAlignmentCenter;
    [MatchLable sizeToFit];
    MatchLable.text=@"匹配率";
    self.MatchLable=MatchLable;
    [MatchBtn addSubview:MatchLable];
    MatchBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    UIImageView *CheckMark= [[UIImageView alloc]init];
//    CheckMark.backgroundColor=FHRandomColor;
    CheckMark.image=[UIImage imageNamed:@"login_arrow"];
    CheckMark.transform = CGAffineTransformMakeRotation(-M_PI_2);
    self.CheckMark = CheckMark;
    [self.contentView addSubview:CheckMark];
    
    UIView *LineView=[[UIView alloc]init];
    self.LineView=LineView;
    LineView.backgroundColor=FHColor(240, 240, 240);
    [self.contentView addSubview:LineView];
    //是否是5S;5S的字体变小
    if ([UIScreen mainScreen].bounds.size.width<375) {
        self.appointBtn.titleLabel.font=[UIFont systemFontOfSize:10];
        self.flowerBtn.titleLabel.font=[UIFont systemFontOfSize:10];
        self.BannerBtn.titleLabel.font=[UIFont systemFontOfSize:10];
    }
    [self SetLayout];
}
-(void)SetLayout{
    [self.MatchLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.MatchBtn.mas_left);
        make.right.equalTo(self.MatchBtn.mas_right);
        make.top.equalTo(self.MatchBtn.mas_top).offset(3);
        make.height.equalTo(@20);
    }];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(10);
        make.height.width.equalTo(@(60));
    }];
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView.mas_top);
        make.left.equalTo(self.iconView.mas_right).offset(10);
    }];
    [self.ProfessLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLable.mas_centerY);
        make.left.equalTo(self.nameLable.mas_right).offset(10);
    }];
    [self.Hospital mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLable.mas_bottom).offset(5);
        make.left.equalTo(self.nameLable.mas_left);
    }];
    [self.appointBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.iconView.mas_bottom);
        make.left.equalTo(self.nameLable.mas_left);
        make.height.equalTo(@(15));
        make.width.equalTo(self.flowerBtn.mas_width);
//        make.right.equalTo(self.flowerBtn.mas_left);
    }];
    [self.flowerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.appointBtn.mas_bottom);
        make.left.equalTo(self.appointBtn.mas_right);
        make.height.equalTo(@(15));
        make.width.equalTo(self.appointBtn.mas_width);
//        make.right.equalTo(self.appointBtn.mas_left);
    }];
    [self.BannerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.flowerBtn.mas_bottom);
        make.left.equalTo(self.flowerBtn.mas_right);
        make.height.equalTo(@(15));
        make.width.equalTo(self.flowerBtn.mas_width);
        make.right.equalTo(self.MatchBtn.mas_left).offset(-50);
    }];
    [self.MatchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.width.equalTo(@45);
        make.height.equalTo(@55);
        make.right.equalTo(self.CheckMark.mas_left).offset(-10);
    }];
    [self.CheckMark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-5);
        make.width.equalTo(@15);
        make.height.equalTo(@13);
    }];
    [self.LineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-1);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(@1);
        make.left.equalTo(self.mas_left);
    }];
}
-(void)setDoctorInfoModel:(FHDoctorInfoModel *)DoctorInfoModel{
    _DoctorInfoModel=DoctorInfoModel;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:DoctorInfoModel.doctor_portrait] placeholderImage:[UIImage imageNamed:@"doctor_default"]];
    self.nameLable.text=DoctorInfoModel.doctor_name;
    self.ProfessLable.text=DoctorInfoModel.doctor_title_name;
    self.Hospital.text=DoctorInfoModel.doctor_hospital_name;
    [self.appointBtn setTitle:[NSString stringWithFormat:@"%d",DoctorInfoModel.operation_count] forState:UIControlStateNormal];
    [self.flowerBtn setTitle:[NSString stringWithFormat:@"%d",DoctorInfoModel.flower] forState:UIControlStateNormal];
    [self.BannerBtn setTitle:[NSString stringWithFormat:@"%d",DoctorInfoModel.banner] forState:UIControlStateNormal];
    [self.MatchBtn setTitle:[NSString stringWithFormat:@"%@",DoctorInfoModel.accuracy] forState:UIControlStateNormal];
}
@end

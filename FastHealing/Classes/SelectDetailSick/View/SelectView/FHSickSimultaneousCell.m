//
//  FHSickSimultaneousCell.m
//  dcDemo
//
//  Created by ZhangZiang on 16/1/20.
//  Copyright © 2016年 ZhangZiang. All rights reserved.
//

#import "FHSickSimultaneousCell.h"
#import "Masonry.h"

@interface FHSickSimultaneousCell ()

@property (nonatomic, weak) UILabel *sickNameLabel;

@property (nonatomic, weak) UIButton *maskView;

@end

@implementation FHSickSimultaneousCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIButton *maskView = [[UIButton alloc]init];
        
        self.maskView = maskView;
        
        [maskView setImage:[UIImage imageNamed:@"sick_Unselected"] forState:UIControlStateNormal];
        [maskView setImage:[UIImage imageNamed:@"sick_Selected"] forState:UIControlStateSelected];
        
        [maskView addTarget:self action:@selector(maskThisCell:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:maskView];
        
        
        
        //设置名字的label
        UILabel *textLabel = [[UILabel alloc]init];
        
        self.sickNameLabel = textLabel;
        
        [self.contentView addSubview:textLabel];
        


    };
    return self;
}

- (void)setSickModel:(FHSickSimultaneous *)sickModel {
    _sickModel = sickModel;
    
     self.sickNameLabel.text = sickModel.complication_name;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat margin = 15;
    
//    self.maskView.frame = CGRectMake(300, 0, 35, 35);
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-margin);
    }];
    
//    self.sickNameLabel.frame = CGRectMake(5, 5, 250, 31);
    [self.sickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(margin);
        make.centerY.equalTo(self);
    }];
    }

- (void)maskThisCell:(UIButton *)maskBtn {
//    NSLog(@"mask!");

    if (self.blockSelected) {
        self.blockSelected();
    }
//    self.maskView.selected = self.maskView.selected ? NO : YES;
    
}

- (void)maskThisCell {
    //    NSLog(@"mask!");
    
    self.maskView.selected = self.maskView.selected ? NO : YES;
}

@end

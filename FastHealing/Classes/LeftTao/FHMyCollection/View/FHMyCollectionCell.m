//
//  FHMyCollectionCell.m
//  FastHealing
//
//  Created by tao on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHMyCollectionCell.h"
#import "UIImageView+WebCache.h"
#import "FHMyCollectionModel.h"
#import "ViewController.h"
@interface FHMyCollectionCell()
/**
 *  关注的医生的名字
 */
@property (weak, nonatomic) IBOutlet UILabel *docName;
/**
 *  关注的医生的职位
 */
@property (weak, nonatomic) IBOutlet UILabel *docPosition;
/**
 *  医院名字
 */
@property (weak, nonatomic) IBOutlet UILabel *hospitalName;
/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/**
 *  咨询按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *cnsultBtn;

/**
 *  手术
 */
@property (weak, nonatomic) IBOutlet UIView *surgeryView;

/**
 *  锦旗
 */
@property (weak, nonatomic) IBOutlet UIView *flagView;

/**
 *  鲜花
 */
@property (weak, nonatomic) IBOutlet UIView *flowerView;
/**
 *  手术量
 */
@property (weak, nonatomic) IBOutlet UILabel *operationLabel;
/**
 *  锦旗数量
 */
@property (weak, nonatomic) IBOutlet UILabel *flagLabel;
/**
 *  鲜花数
 */
@property (weak, nonatomic) IBOutlet UILabel *flowerLabel;

@end


@implementation FHMyCollectionCell


+ (instancetype)loadCellWith:(UITableView *)tableView{
    
  FHMyCollectionCell *cell =  [[NSBundle mainBundle] loadNibNamed:@"FHMyCollectionCell" owner:nil options:nil].lastObject;
    
    return  cell;
}



- (void)awakeFromNib {
    
    
}

//重写模型属性的set方法
- (void)setCollectionModel:(FHMyCollectionModel *)collectionModel{
    _collectionModel = collectionModel;
    self.docName.text = collectionModel.doctor_name;
    self.docPosition.text = collectionModel.doctor_title_name;
    self.hospitalName.text = collectionModel.hospital_name;
    self.flowerLabel.text = collectionModel.flower;
    self.flagLabel.text = collectionModel.banner;
    self.operationLabel.text = collectionModel.operation_count;
    NSURL *url = [NSURL URLWithString:collectionModel.doctor_portrait];
    
//    [self.iconView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        
//    }];
    self.iconView.layer.cornerRadius = 30;
    self.iconView.layer.masksToBounds = YES;
    [self.iconView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"doctor_default"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
}







- (IBAction)talkBtnClick:(UIButton *)sender {
    
    NSLog(@"点击了关注界面的咨询按钮");
    
    ViewController *vc = [ViewController loadVC];
    
    if (self.talkBlockl) {
        self.talkBlockl(vc);
    }
    
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    
//    
//}

@end

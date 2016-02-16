//
//  FHTFamousCell.m
//  FastHealing
//
//  Created by tao on 16/1/21.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHTFamousCell.h"
#import "FHFamousModel.h"
@interface FHTFamousCell()
/**
 *  患者名字
 */
@property (weak, nonatomic) IBOutlet UILabel *userName;
/**
 *  病备注
 */
@property (weak, nonatomic) IBOutlet UILabel *thirdName;
/**
 *  时间
 */
@property (weak, nonatomic) IBOutlet UILabel *date;
/**
 *  状态
 */
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
/**
 *  医院名字
 */
@property (weak, nonatomic) IBOutlet UILabel *hospitalName;
/**
 *  医生职位
 */
@property (weak, nonatomic) IBOutlet UILabel *docPosition;
/**
 *  医生名字
 */
@property (weak, nonatomic) IBOutlet UILabel *docName;
/**
 *  分割线
 */
@property (weak, nonatomic) IBOutlet UIView *lineView;


//右上角的圆
@property (weak, nonatomic) IBOutlet UIView *redView;

@end





@implementation FHTFamousCell

//实现加载的方法
+ (instancetype)famousCellWith:(UITableView *)tableView{
    FHTFamousCell *cell = [[NSBundle mainBundle] loadNibNamed:@"FHTFamousCell" owner:nil options:nil].firstObject;
    return cell;
}


//重写set方法给模型属性里面的赋值
- (void)setFamousModel:(FHFamousModel *)famousModel{
    _famousModel = famousModel;
    self.userName.text = famousModel.true_name;
    
    self.docName.text = famousModel.doctor_name;
    self.hospitalName.text = famousModel.hospital_name;
    self.docPosition.text = famousModel.doctor_title_name;
    self.date.text = famousModel.duty_date;
    self.thirdName.text = famousModel.ci3_name;
    self.statusLabel.layer.cornerRadius = 20;
    self.statusLabel.layer.masksToBounds = YES;
    self.statusLabel.text = famousModel.order_status;
    if ([famousModel.order_status isEqualToString:@"已就诊"]) {
    //灰色
        //颜色: 21  162  213
        
       // 244 128  131 (粉红)
        
        //163 (灰色)
        self.redView.hidden = YES;
       UIColor *color = FHColor(163, 163, 163);
        [self setColorForViewWith:color];
       
    }else if ([famousModel.order_status isEqualToString:@"申请失败"]){
        //红色
        UIColor *color = FHColor(244, 128, 131);
        [self setColorForViewWith:color];
        self.redView.layer.cornerRadius = 7;
        self.redView.layer.masksToBounds = YES;
        self.redView.backgroundColor = color;
        self.redView.hidden = NO;
        
    }else{
        UIColor *color = FHColor(21, 162, 213);
        self.redView.hidden = YES;
        [self setColorForViewWith:color];
        
    }
    
    
}


- (void)setColorForViewWith:(UIColor *)color{
    self.lineView.backgroundColor = color;
    self.statusLabel.backgroundColor = color;
}

- (void)awakeFromNib {
  
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

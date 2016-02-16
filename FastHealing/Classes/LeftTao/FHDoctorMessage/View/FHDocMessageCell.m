//
//  FHDocMessageCell.m
//  FastHealing
//
//  Created by tao on 16/1/22.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHDocMessageCell.h"
#import "FHDoctorMessageModel.h"
#import "FHRequireModel.h"

@interface FHDocMessageCell()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
//@property (weak, nonatomic) IBOutlet UILabel *goodTest;
@property (weak, nonatomic) IBOutlet UIView *fatherView;

@end


@implementation FHDocMessageCell

- (void)awakeFromNib {
    // Initialization code
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableview.estimatedRowHeight = 40;
}

+ (instancetype)loadDocMessageCellWith:(UICollectionView *)collectionView{
    FHDocMessageCell *cell =  [[[NSBundle mainBundle] loadNibNamed:@"FHDocMessageCell" owner:nil options:nil] lastObject];
    
    return cell;
    
}



//重写模型set方法给属性赋值
- (void)setMessageModel:(FHDoctorMessageModel *)messageModel{
    _messageModel = messageModel;
    if (messageModel.isIntroduction) {
        self.fatherView.hidden = NO;
        self.textView.text = messageModel.introduction;
//        self.iconView.hidden = YES;
//        self.nameLabel.hidden = YES;
//        self.tableview.hidden = YES;
//        
    }else{
         self.fatherView.hidden = YES;
    }
}



#pragma mark 实现tableView的数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.requireModel.receiving_settings.count;
}



/**
 *  
 str:{"msg":"OK","data":{"receiving_setting_extra":"特殊条件特殊条件特殊条件特殊条件特殊条件特殊条件 特殊条件特殊条件特殊条件特殊条件特殊条件特殊条件特殊条件特殊条件特殊条件啊谁都发生地方","receiving_settings":["需要提供并发症","需要患者为首诊","需要提供个人史","需要提供疾病描述","需要提供病例"]},"code":0}
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" ];
//    if (indexPath.row == 0) {
//        cell.textLabel.text = @"需要提供个人史";
//    }else if (indexPath.row == 1){
//        cell.textLabel.text = @"需要提供疾病描述";
//    }else{
//         cell.textLabel.text = @"需要提供病例";
//    }
    cell.textLabel.text = self.requireModel.receiving_settings[indexPath.row];
    cell.textLabel.numberOfLines = 0;
    [cell.textLabel sizeToFit];
    self.tableview.rowHeight = cell.textLabel.bounds.size.height;
   // cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)setRequireModel:(FHRequireModel *)requireModel{
    _requireModel = requireModel;
    [self.tableview reloadData];
}
@end
















//
//  FHSpecialView.m
//  FastHealing
//
//  Created by tao on 16/1/23.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHSpecialView.h"
#import "FHRequireModel.h"
#import "FHDoctorMessageModel.h"

@interface FHSpecialView()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *extenLabel;


@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end




@implementation FHSpecialView


+ (instancetype)loadSpecialView{
    FHSpecialView *view = [[[NSBundle mainBundle]loadNibNamed:@"FHSpecialView" owner:nil options:nil] lastObject];
  
    return view;
}


- (void)awakeFromNib{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


//实现数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.requireModel.receiving_settings.count;
}


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
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor lightGrayColor];
    [cell.textLabel sizeToFit];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.tableView.rowHeight = cell.textLabel.bounds.size.height;
    return cell;
}


- (void)setMessageModel:(FHDoctorMessageModel *)messageModel{
    _messageModel = messageModel;
    if (messageModel.isIntroduction) {
       
        self.textView.hidden = NO;
        self.textView.text = messageModel.introduction;
    }else{
        self.textView.hidden = YES;
    }
    [self.tableView reloadData];
}

- (void)setRequireModel:(FHRequireModel *)requireModel{
    _requireModel = requireModel;
    
    self.extenLabel.text = requireModel.receiving_setting_extra;
    [self.tableView reloadData];
    
}


@end










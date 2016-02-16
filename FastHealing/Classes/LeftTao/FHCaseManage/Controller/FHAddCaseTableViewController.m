//
//  FHAddCaseTableViewController.m
//  FastHealing
//
//  Created by tao on 16/1/25.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHAddCaseTableViewController.h"
#import "FHAddCaseCell.h"
#import "FHSickDetailController.h"
#import "FHChangeBigCaseTC.h"
#import "FHChangeBigCaseModel.h"
#import "SVProgressHUD.h"
#import "FHSickSimultaneousController.h"
#import "FHSickSimultaneous.h"
#import "FHAddCaseThirdCell.h"


@interface FHAddCaseTableViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
/**
 *  疾病细分
 */
@property (strong, nonatomic) UILabel *diseaseSypeLabel;
@property (strong, nonatomic) UILabel *caseSypeLabel;
/**
 *  疾病类型id
 */
@property (assign, nonatomic)  NSInteger ci1_id;

@property (assign, nonatomic)  NSInteger ci2_id;

/**
 *  病例描述
 */
@property (strong, nonatomic) UILabel *disLabel;

/**
 *  添加图片
 */
@property (strong, nonatomic) UIImageView *addImageView;

//占位文本
@property (strong, nonatomic) UITextField *texField;

@end

@implementation FHAddCaseTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = [[UIView alloc]init];
    // UITableView *view = [UITableView alloc]
    self.tableView.estimatedRowHeight = 80;
    //self.tableView.rowHeight = 120;
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(8, FHScreenSize.height - 72 - 64, FHScreenSize.width - 16, 64)];
    [self.view addSubview:btn];
    btn.layer.cornerRadius = 10;
    
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    [btn setBackgroundColor:FHColor(119, 211, 235)];
    [btn addTarget:self action:@selector(resultBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
}


- (void)resultBtnClick{
    //NSLog(@"点击了确认按钮");
    [self save];
    [SVProgressHUD showSuccessWithStatus:@"生成病例完成请去相册查看"];
    
}


- (void)save{
    
    //就是截屏
    
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO , 0);
    
    //获得当前路径
    
    CGContextRef tef = UIGraphicsGetCurrentContext();
    
    //截图
    
    [self.view.layer renderInContext:tef];
    
    //获得图片
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭
    
    UIGraphicsEndPDFContext();
    
    //把图片存入相册
    
    UIImageWriteToSavedPhotosAlbum(image, NULL, NULL, NULL);
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 实现数据源

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
    
}

//每组数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        
        return 2;
    }else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
   
    
    if (indexPath.section == 0) {
        FHAddCaseCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"FirstYG"];
        if (cell == nil) {
            cell = [FHAddCaseCell loadFirstSectionCell];
        }
        UILabel *diseaseSypeLabel = [cell viewWithTag:1111];
       
        diseaseSypeLabel.text = @"请选择";
        diseaseSypeLabel.textColor = [UIColor lightGrayColor];
         UILabel *caseType = [cell viewWithTag:1110];
        if (indexPath.row == 0) {
            caseType.text = @"疾病类型:";
        }else{
           caseType.text = @"疾病细分:";
        }
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
      return cell;
    }else if(indexPath.section == 1){
        FHAddCaseCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SecondYG"];
        if (cell == nil) {
            cell = [FHAddCaseCell loadSecondSectionCell];
        }
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
       return cell;
    }else if(indexPath.section == 2){
        FHAddCaseCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ThirdYG"];
        if (cell == nil) {
            cell = [FHAddCaseCell loadThirdSectionCell];
        }
        //1113是colletion
        
        //1114是text
        UILabel *label = [cell viewWithTag:4444];
        self.disLabel = label;
        self.disLabel.hidden = YES;
        UITextField *textField = [cell viewWithTag:5555];
        self.texField = textField;
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        FHAddCaseCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ForthYG"];
        if (cell == nil) {
            cell = [FHAddCaseCell loadForthSectionCell];
        }
        
        //6666
        UIImageView *imageView = [cell viewWithTag:6666];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addImageViewClick:)];
       
        
        self.addImageView = imageView;
        
         [self.addImageView addGestureRecognizer:tap];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
   
}


//实现图片的点击

- (void)addImageViewClick:(UITapGestureRecognizer *)tap{
    
   // NSLog(@"点击了天机病例图片");
    
    UIAlertController *alertControler = [UIAlertController alertControllerWithTitle:@"请选择病例图片" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"请选择病例图片"];
    [title addAttribute:NSFontAttributeName
                  value:[UIFont systemFontOfSize:26]
                  range:NSMakeRange(0, 7)];
    
    
        [title addAttribute:NSForegroundColorAttributeName value:[UIColor purpleColor] range:NSMakeRange(0, 7)];
    
    
    //[alertVC setValue:hogan forKey:@"attributedTitle"];
    [alertControler setValue:title forKey:@"attributedTitle"];
    
    //alertControler tex
    
   // UITextField *field = alertControler.textFields[0];
    //field.text = @"hdhfh";
    
    //alertControler.te
    //- (void)addAction:(UIAlertAction *)action
    //1.从相册中取图片,创建action
    UIAlertAction *pictureAction = [UIAlertAction actionWithTitle:@"照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // NSLog(@"heheh");
        //这里是点击了相应的按钮的时候会调用
        UIImagePickerController *pictureVC = [[UIImagePickerController alloc]init];
        //设置照片来源
        pictureVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //设置代理
        pictureVC.delegate = self;
        //推出相册
        [self presentViewController:pictureVC animated:YES completion:nil];
        
    }];
    [alertControler addAction:pictureAction];
    //2.设置相机cameraAction
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了相机");
        UIImagePickerController *pictureVC = [[UIImagePickerController alloc]init];
        //设置为相加
        pictureVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        //设置代理
        pictureVC.delegate = self;
        //展示界面
        [self presentViewController:pictureVC animated:YES completion:nil];
        
    }];
    //添加相机的选项
    [alertControler addAction:cameraAction];
    //3.添加取消
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertControler addAction:actionCancel];
    
    [self presentViewController:alertControler animated:YES completion:nil];
    



}


//控制头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 || section == 2) {
        return 0;
    }else{
        return 15;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}


#pragma mark 实现代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 ){
        //获得点击的cell
        if (indexPath.row == 0) {
            FHChangeBigCaseTC *caseTC = [[FHChangeBigCaseTC alloc]init];
            [self.navigationController pushViewController:caseTC animated:YES];
                        FHAddCaseCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            UILabel *caseSypeLabel = [cell viewWithTag:1111];
            self.caseSypeLabel = caseSypeLabel;
            
            caseTC.changeBlock = ^(FHChangeBigCaseModel *model){
                caseSypeLabel.text = model.caseName;
                self.diseaseSypeLabel.text = @"请选择";
                self.ci1_id = model.ci1_id;
            };
        //跳到疾病类型接口
        }else{
            if (self.caseSypeLabel.text.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"请先选择疾病类型"];
                return;
            }
            
            //跳到疾病细分
            [self sickDetailViewTaped];
            FHAddCaseCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            UILabel *diseaseSypeLabel = [cell viewWithTag:1111];
            self.diseaseSypeLabel = diseaseSypeLabel;
        }
    }
    
    if (indexPath.section == 1) {
        NSLog(@"%@",self.diseaseSypeLabel.text );
        if ( self.diseaseSypeLabel.text.length == 0 ||        [self.diseaseSypeLabel.text isEqualToString:@"请选择"]) {
             [SVProgressHUD showErrorWithStatus:@"请先疾病细分"];
        }else{
            //跳到症状界面
            [self sickSimultaneousTaped];
        }
        
        
        
    }
}

//选择并发症
- (void)sickSimultaneousTaped {
    //if (self.hasSelectedFirst) {
        FHSickSimultaneousController *sickSim = [[FHSickSimultaneousController alloc]init];
        
        [self.navigationController pushViewController:sickSim animated:YES];
        
        sickSim.ci2_id = self.ci2_id;
        
        //block赋值
        sickSim.blockSelected = ^(NSArray *sickSimModels) {
            
            //FHSickSimultaneous *model  = sickSimModels[0];
            //NSLog(@"%@",model.complication_name);
            self.texField.hidden = YES;
            self.disLabel.hidden = NO;
            NSMutableString *selectedName = [NSMutableString string];
            
            for (FHSickSimultaneous *model in sickSimModels) {
                [selectedName appendString:model.complication_name];
                
                [selectedName appendString:@","];
            }
            
            [selectedName deleteCharactersInRange:NSMakeRange(selectedName.length-1, 1)];
            

            self.disLabel.text = selectedName;
            
   
        };
    
}


//选择分类疾病
- (void)sickDetailViewTaped {
    FHSickDetailController *sickDetailVC = [[FHSickDetailController alloc]init];
    sickDetailVC.ci1_id = self.ci1_id;
    [self.navigationController pushViewController:sickDetailVC animated:YES];
    //拿到逆传值
    sickDetailVC.blockSelected = ^(FHDetailSick *sick) {
        NSLog(@"ttttttt%@",sick.ci3_name);
        self.diseaseSypeLabel.text = sick.ci3_name;
        self.ci2_id = sick.ci2_id;
    };
}





#pragma mark 实现代理方法
//选择照片的时候会调用
//实现代理方法之后选择图片后相册不会自动消失
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSLog(@"%@",info);
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.addImageView.image = image;
    //把数据上传到服务器
   // XMPPvCardTemp *temp = [YGXMPPTool shareXMPPTool].xmppCardTempModule.myvCardTemp;
   // NSData *data = UIImageJPEGRepresentation(image, 0.1);
    //[temp setPhoto:data];
    //更新自己的名片模块到服务器
    //[[YGXMPPTool shareXMPPTool].xmppCardTempModule updateMyvCardTemp:temp];
    //让相册消失
    [self dismissViewControllerAnimated:picker completion:nil];
}


//返回行高

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 2) {
//        return 120;
//    }else if(indexPath.section == 3){
//        return 180;
//    }else{
//        return 40;
//    }
//}


@end

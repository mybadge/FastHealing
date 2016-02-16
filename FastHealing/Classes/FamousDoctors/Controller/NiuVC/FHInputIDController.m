//
//  FHInputIDController.m
//  FastHealing
//
//  Created by xianbinniu on 16/1/24.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHInputIDController.h"

@interface FHInputIDController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *ID;

@property (weak, nonatomic) IBOutlet UIButton *BtnClick;

@end

@implementation FHInputIDController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"输入实名信息";
    self.BtnClick.enabled=NO;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(valueChange) name:UITextFieldTextDidChangeNotification object:nil];
}
-(void)valueChange{
    if (self.name.hasText&&self.ID.hasText) {
      self.BtnClick.enabled=YES;
    }
}
- (IBAction)BtnClick:(id)sender {
 BOOL flag= [self validateIdentityCard:self.ID.text];
    if (flag) {
        [self.navigationController popViewControllerAnimated:YES];
        //本地存储
        [[NSUserDefaults standardUserDefaults]setValue:self.name.text forKey: NUserRealName];
        [[NSUserDefaults standardUserDefaults]setValue:self.name.text forKey: NUserRealID];
    }else{
        UILabel *lable = [[UILabel alloc]init];
        lable.text=@"身份证格式不合法";
        lable.textColor=[UIColor whiteColor];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.frame= CGRectMake((FHScreenSize.width-200)/2, FHScreenSize.height-180, 200, 40);
        [self.view addSubview:lable];
        lable.layer.cornerRadius=25;
        lable.backgroundColor=[UIColor blackColor];
        lable.layer.masksToBounds=YES;
        lable.alpha=0;
        [UIView animateWithDuration:0.5 animations:^{
            lable.alpha=0.6;
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.5 animations:^{
                lable.alpha=0;
            } completion:^(BOOL finished) {
                [lable removeFromSuperview];
                
            }];
        }];
    }
}

//谓词过滤身份证号
- (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UILabel *lable = [[UILabel alloc]init];
    lable.text=@"请绑定实名信息";
    lable.textColor=[UIColor whiteColor];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.frame= CGRectMake((FHScreenSize.width-200)/2, FHScreenSize.height-180, 200, 40);
    [self.view addSubview:lable];
    lable.layer.cornerRadius=25;
    lable.backgroundColor=[UIColor blackColor];
    lable.layer.masksToBounds=YES;
    lable.alpha=0;
    [UIView animateWithDuration:0.5 animations:^{
        lable.alpha=0.6;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5 animations:^{
            lable.alpha=0;
        } completion:^(BOOL finished) {
            [lable removeFromSuperview];
            
        }];
    }];
}

@end

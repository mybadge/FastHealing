//
//  FHDoctorCaseReportScrollView.m
//  FastHealing
//
//  Created by xianbinniu on 16/1/24.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHDoctorCaseReportScrollView.h"
#import "FHDoctorCaseReportController.h"
@interface FHDoctorCaseReportScrollView ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *lastView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *Constraint;
@property (weak, nonatomic) IBOutlet UIImageView *IconView;
@property(nonatomic,strong)  UIImagePickerController *picker;
@property(nonatomic,weak)   FHDoctorCaseReportController *vc;
@end

@implementation FHDoctorCaseReportScrollView

+(instancetype)loadCaseReportScrollView{
    return [[[NSBundle mainBundle]loadNibNamed:@"FHDoctorCaseReportScrollView" owner:nil options:nil]firstObject];
}
- (IBAction)BtnClick:(id)sender {
    //TODO,按钮点击有问题...ScrollView添加手势也有问题(冲突);
        UIImagePickerController *picker=[[UIImagePickerController alloc]init];
        picker.delegate=self;
        self.picker=picker;
        picker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        FHDoctorCaseReportController *vc=(FHDoctorCaseReportController *)[self getSuperViewContor];
        [vc presentViewController:picker animated:YES completion:nil];
}
//- (IBAction)tap:(UITapGestureRecognizer *)sender {
//    NSLog(@"123");
//    UIImagePickerController *picker=[[UIImagePickerController alloc]init];
//    picker.delegate=self;
//    self.picker=picker;
//    picker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//    FHDoctorCaseReportController *vc=(FHDoctorCaseReportController *)[self getSuperViewContor];
//    [vc presentViewController:picker animated:YES completion:nil];
//    self.vc=vc;
//}
//UIimagePicker的代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //UIImage *image=info[UIImagePickerControllerOriginalImage];
    //    self.PhotoView.backgroundColor=[UIColor ];

}
-(void)layoutSubviews{
    [super layoutSubviews];
    //解决屏幕适配6SP的问题,必须调整约束宽度;
   self.Constraint.constant=self.width;
    self.contentSize=CGSizeMake(FHScreenSize.width, CGRectGetMaxY(self.lastView.frame)+150);
}
-(UIViewController *)getSuperViewContor{
    //当前视图的下一个响应者;
    UIResponder *Responder = [self nextResponder];
    while (Responder!=nil) {
        if ([Responder isKindOfClass:[FHDoctorCaseReportController class]]) {
            return (UIViewController*)Responder;
        } ;
    }
    return nil;
}
@end

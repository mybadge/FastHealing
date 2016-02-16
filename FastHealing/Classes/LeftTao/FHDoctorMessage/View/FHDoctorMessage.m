//
//  FHDoctorMessage.m
//  FastHealing
//
//  Created by tao on 16/1/22.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHDoctorMessage.h"
#import "FHMyCollectionModel.h"
#import "UIImageView+WebCache.h"
#import "FHDoctorMessageModel.h"
#import "Masonry.h"
#import "FHDocMessageCell.h"
#import "FHDocIntroduceView.h"
#import "FHHeadScrolView.h"
#import "FHRequireModel.h"
#import "SVProgressHUD.h"
#import "FHConsultTableView.h"
#import "ViewController.h"

#define CELLID @"FHDocrorMessageYG"
@interface FHDoctorMessage()<UICollectionViewDelegate>
/**
遮罩view
 */

@property (strong, nonatomic) UIView *coverView;
@property (strong, nonatomic) UIView *choceView;

/**
 *  医生头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/**
 *  医生名字
 */
@property (weak, nonatomic) IBOutlet UILabel *docNameLabel;
/**
 *  医院名字
 */
@property (weak, nonatomic) IBOutlet UILabel *docPosition;

@property (weak, nonatomic) IBOutlet UILabel *hospitacName;
/**
 *  预约量头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *appointCount;
/**
 *  预约量
 */
@property (weak, nonatomic) IBOutlet UILabel *appointCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *flowerView;
@property (weak, nonatomic) IBOutlet UILabel *fkowerCount;
@property (weak, nonatomic) IBOutlet UIImageView *flagView;
@property (weak, nonatomic) IBOutlet UILabel *flagCount;

@property (weak, nonatomic) IBOutlet UIButton *askDocBtn;

@property (weak, nonatomic) IBOutlet FHDocIntroduceView *jianjieView;

/**
 *  上部的滚动
 */
//@property (weak, nonatomic) IBOutlet UIView *headScroView;
@property (weak, nonatomic) IBOutlet FHHeadScrolView *headScroView;

//@property (assign, nonatomic)  BOOL isRight;
@end


@implementation FHDoctorMessage

+ (instancetype)loadDoctorMessage{
    
    FHDoctorMessage *docMessView = [[[NSBundle mainBundle] loadNibNamed:@"FHDoctorMessage" owner:nil options:nil] lastObject];
    return docMessView;
}


- (void)awakeFromNib{
//self.jianjieView.collectionView
    self.jianjieView.collectionView.delegate = self;
    //1001是左边按钮
    //1002是右边按钮
    //1003是下边的view
   // self.headScroView viewWithTag:<#(NSInteger)#>
    //self.jianjieView.
    
    self.headScroView.scrollViewChangeBlock = ^(BOOL isIntroduct){
#pragma mark 点击按钮让scrollView的位置改变
        //NSLog(@"block吊样了吗");
       // self.isRight = isIntroduct;
        if (isIntroduct) {
             //NSLog(@"block吊样了吗");
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
            
            [self.jianjieView.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        
            
        }else{
            // NSLog(@"这个是基本条件吗");
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            
            [self.jianjieView.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
            
        }
        
        
    };
    
    
    
    
}

#pragma mark 重写collection的数据源给医生模块赋值
- (void)setCollectionDocModel:(FHMyCollectionModel *)collectionDocModel{
    _collectionDocModel = collectionDocModel;
    self.docNameLabel.text = collectionDocModel.doctor_name;
  
    self.docPosition.text = collectionDocModel.doctor_title_name;
    self.hospitacName.text = collectionDocModel.hospital_name;
    self.fkowerCount.text = collectionDocModel.flower;
    self.flagCount.text = collectionDocModel.banner;
    self.appointCountLabel.text = collectionDocModel.operation_count;
    NSURL *url = [NSURL URLWithString:collectionDocModel.doctor_portrait];
    self.iconView.layer.cornerRadius = 30;
    self.iconView.layer.masksToBounds = YES;
    [self.iconView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"doctor_default"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    //FHDocIntroduceView *introduceView = [[FHDocIntroduceView alloc]init];
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor blackColor];

}


//重写医生的技能模型
- (void)setDocMessageModel:(FHDoctorMessageModel *)docMessageModel{
    _docMessageModel = docMessageModel;
    
    self.jianjieView.messageModel = docMessageModel;
    
}

- (void)setRequireModel:(FHRequireModel *)requireModel{
    _requireModel = requireModel;
    //NSLog(@"6666666666%ld",requireModel.receiving_settings.count);
    self.jianjieView.requireModel = requireModel;
}
#pragma mark 实现scrollView的代理方法

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    //NSLog(@"点击了下边滚动的cell");
//    
//    
//    
//}


//滚动的时候调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //NSLog(@"滚动的时候调用");
    //滚动的时候让滚条的位置改变
    // NSLog(@"%f",scrollView.contentOffset.x);
    UIView *lineView = [self.headScroView viewWithTag:1003];
    lineView.x = scrollView.contentOffset.x/2;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    UIButton *btnRight = [self.headScroView viewWithTag:1001];
    UIButton *btnLeft = [self.headScroView viewWithTag:1000];
    BOOL isRight = scrollView.contentOffset.x == FHScreenSize.width;
    
    if (isRight) {
       
        [btnRight setTitleColor:FHColor(119, 211, 215) forState:UIControlStateNormal];
      
        [btnLeft setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        
    }else{
       // UIButton *btnRight = [self.headScroView viewWithTag:1002];
        [btnLeft setTitleColor:FHColor(119, 211, 215) forState:UIControlStateNormal];
       // UIButton *btnLEft = [self.headScroView viewWithTag:1001];
        [btnRight setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    }
}



#pragma mark 点解咨询按钮

- (IBAction)askBtnClick:(UIButton *)sender {
    
    NSLog(@"点击了咨询按钮");
    //创建一个遮罩view
    UIView *coverView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    coverView.backgroundColor = [UIColor darkGrayColor];
    coverView.alpha = 0.6;
    //添加手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(coverViewClick)];
    [coverView addGestureRecognizer:tapGesture];
    self.coverView = coverView;
    [self addSubview:coverView];
    //创建一个选择view
    UIView *choceView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width*0.6, [UIScreen mainScreen].bounds.size.height*0.4)];
    UIImage *image = [UIImage imageNamed:@"gongyi_bk"];
    image = [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
    choceView.backgroundColor = FHColor(119, 211, 234);
    choceView.centerX = self.centerX;
    choceView.centerY = self.centerY;
    self.choceView = choceView;
    [self addSubview:choceView];
    //choceView添加按钮
    CGFloat height = choceView.height/4.0;
    CGFloat margin = height/2.0;
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"打 电 话" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [choceView addSubview:btn];
    [btn setBackgroundImage:image forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(makeTellBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(choceView.mas_left);
         make.right.equalTo(choceView.mas_right);
        make.top.equalTo(choceView.mas_top);
        make.height.multipliedBy(1/4.0).equalTo(choceView.mas_height);
        
    }];
    
    //视频
    UIButton *btn1 = [[UIButton alloc]init];
    [btn1 setTitle:@"视  频" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [choceView addSubview:btn1];
    [btn1 setBackgroundImage:image forState:UIControlStateHighlighted];
     [btn1 addTarget:self action:@selector(videoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(choceView.mas_left);
        make.right.equalTo(choceView.mas_right);
        make.top.equalTo(btn.mas_bottom).offset(margin);
        make.height.multipliedBy(1/4.0).equalTo(choceView.mas_height);
        
    }];
    //发消息
    UIButton *btn2 = [[UIButton alloc]init];
    [btn2 setTitle:@"发 消 息" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [choceView addSubview:btn2];
    [btn2 setBackgroundImage:image forState:UIControlStateHighlighted];
    [btn2 addTarget:self action:@selector(messageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(choceView.mas_left);
        make.right.equalTo(choceView.mas_right);
        make.top.equalTo(btn1.mas_bottom).offset(margin);
        make.height.multipliedBy(1/4.0).equalTo(choceView.mas_height);
        
    }];
   
}

//实现点击的效果
- (void)coverViewClick{
  [UIView animateWithDuration:0.6 animations:^{
      self.coverView.alpha = 0;
      self.choceView.alpha = 0;
      
  } completion:^(BOOL finished) {
      [self.coverView removeFromSuperview];
      [self.choceView removeFromSuperview];
  }];
  
    //NSLog(@"点击了遮罩view");
    
}


//choseView上按钮的点击事件
- (void)makeTellBtnClick{
    //NSLog(@"打电话");
    [self showAlert];
    
}
- (void)videoBtnClick{
    //NSLog(@"视频");
    [self showAlert];
    
}
- (void)messageBtnClick{
    NSLog(@"跳转到聊天界面发消息");
    [self.choceView removeFromSuperview];
    [self.coverView removeFromSuperview];
    //跳转到聊天界面
     ViewController *tableView = [ViewController loadVC];
    if (self.sendMessageBlock != nil) {
        self.sendMessageBlock(tableView);
    }
}


- (void)showAlert{
    
    [SVProgressHUD showErrorWithStatus:@"别想那么多了发消息吧" maskType:SVProgressHUDMaskTypeNone];
}

@end

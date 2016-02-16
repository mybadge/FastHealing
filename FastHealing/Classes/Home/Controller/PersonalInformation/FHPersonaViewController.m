//
//  FHPersonaViewController.m
//  FastHealing
//
//  Created by 赫腾飞 on 16/1/23.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "UIView+Extension.h"
#import "FHPersonaViewController.h"
#import "Masonry.h"
#import "FHBlackView.h"
#import "FHWeatherPositionViewController.h"
#import "UIImageView+WebCache.h"
#import "HTFPopupWindow.h"
#import "FHUserViewModel.h"
#import "FHUser.h"

#import "FHPersonHeaderDetail.h"

//除导航栏高德height
#define HEIGTH_WITHOUT_BAR (FHScreenSize.height - CGRectGetMaxY(self.navigationController.navigationBar.frame))
//各个VIew 的高度比例
#define HEADER_HEIGHT_SCALE 1/6.0

#define MIDDLE_HEIGHT_SCALE 1/4.0

@interface FHPersonaViewController ()<UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) FHPersonHeaderDetail *headerView;//头像行
@property (nonatomic, weak) UIImageView *header;//头像
@property (nonatomic, strong) UITableView  *middleView;//tabView
@property (nonatomic, strong) UIView *bottomView;//下部text

@property (nonatomic, assign) NSInteger selectIndex;//选中的Cell
@property (nonatomic, weak) UIView *blackView;//蒙板
@property (nonatomic, weak) HTFPopupWindow *pickerView;//选择更改器
@property (nonatomic, weak) UIImageView *personGender;//性别Image

@property (nonatomic, assign) NSInteger firstNum;
@property (nonatomic, assign) NSInteger secondNum;
@property (nonatomic, assign) NSInteger threeNum;
@end

@implementation FHPersonaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0  blue:246/255.0  alpha:1];
    [self setupUI];
    
    self.title = @"个人信息";
    self.middleView.dataSource = self;
    self.middleView.delegate = self;
    [self setNav];

    [ FHNotificationCenter addObserver:self selector:@selector(requestBackCity:) name:@"setPosition" object:nil];

    
}
- (void)setNav{
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    [button setImage:[UIImage imageNamed:@"nav_return"] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(didBack) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
}

- (void)didBack{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dismissVC" object:nil];
}

- (void)setupUI{

    [self.view addSubview:self.headerView];
    self.headerView.backgroundColor = [UIColor whiteColor];
   
    
    [self.view addSubview:self.middleView];
    [self.view addSubview:self.bottomView];
    
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.headerView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.offset( HEIGTH_WITHOUT_BAR * MIDDLE_HEIGHT_SCALE);
//        make.height.offset(self.middleView.height);
        
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.middleView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
        
    }];
    
    [self creatBottomchildView];

}
#pragma mark 懒加载子视图
- (UIView *)bottomView{

    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] init];
        
        _bottomView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0  blue:246/255.0  alpha:1];;
    }
    return _bottomView;
}

- (UITableView *)middleView{
    
    if (_middleView == nil) {
        //添加Cell
       _middleView = [[UITableView alloc] init];
        
        _middleView.backgroundColor = [UIColor whiteColor];
        
        _middleView.scrollEnabled = NO;
    }

    return _middleView;
}

- (FHPersonHeaderDetail *)headerView{
    if (_headerView == nil) {
        
        _headerView = [[FHPersonHeaderDetail alloc] initWithFrame:CGRectMake(0, 64, FHScreenSize.width, HEIGTH_WITHOUT_BAR * HEADER_HEIGHT_SCALE)];
        _headerView.user = [FHUserViewModel shareUserModel].user;
    }
    return _headerView;

}
- (void)creatBottomchildView{
  
    UILabel *lableT = [[UILabel alloc] init];
    lableT.text = @"需要修改个人信息";
    lableT.textAlignment = NSTextAlignmentCenter;
    [self.bottomView addSubview:lableT];
    lableT.textColor = [UIColor lightGrayColor];
    [lableT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bottomView.mas_centerX);
        make.bottom.equalTo(self.bottomView.mas_bottom).offset(-150);
        make.height.offset(34);
        make.width.offset(200);
        
    }];
    
    UILabel *lableB = [[UILabel alloc] init];
    lableB.text = @"客服电话:400-633-1113";
    lableB.textAlignment = NSTextAlignmentCenter;
    [self.bottomView addSubview:lableB];
    lableB.textColor = [UIColor lightGrayColor];
    [lableB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.bottomView.mas_centerX);
        make.top.equalTo(lableT.mas_bottom);
        make.height.offset(34);
        make.width.offset(200);
    }];

    
}


#pragma mark uitableView  datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.detailTextLabel.textAlignment = NSTextAlignmentRight;

    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [button setImage:[UIImage imageNamed:@"login_arrow_right"] forState:UIControlStateNormal];
    cell.accessoryView = button;
    cell.accessoryView.tag = indexPath.row;
    //获取数据
    FHUser *model = [FHUserViewModel shareUserModel].user;
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"身高";
            cell.detailTextLabel.text =  [NSString stringWithFormat:@"%@(cm)",(model != nil? model.height : @"0")];
            [button addTarget:self action:@selector(selectHeight) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 1:
            cell.textLabel.text = @"体重";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@(kg)",(model != nil ? model.weight : @"0")];
            [button addTarget:self action:@selector(selectWeight) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 2:
            cell.textLabel.text = @"省份";
            cell.detailTextLabel.text = model.address ? model.address : @"中国";//@"北京市";
            [button addTarget:self action:@selector(selectCity) forControlEvents:UIControlEventTouchUpInside];
            break;
        default:
            break;
    }
    return cell;
    
}
#pragma mark 弹出框设置
- (void)selectHeight{
    self.selectIndex = 0;
    [self creatPickerSelectViewWith:@"设置身高(cm)"];
}
- (void)selectWeight{
    self.selectIndex = 1;
    [self creatPickerSelectViewWith:@"选择体重(kg)"];
}
- (void)selectCity{
    
    FHBlackView *view = [[FHBlackView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    self.blackView = view;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backViewClick)];
    [view addGestureRecognizer:gesture];
    
    //添加View 替换View
    FHWeatherPositionViewController *positionVC = [[FHWeatherPositionViewController alloc] init];
    positionVC.title = @"中国";
    //添加 父子关系 引用 positionVC 的View
    [self addChildViewController:positionVC];
    
    CGFloat viewW = self.view.width * 4 / 5.0;
    CGFloat viewH = self.view.height * 3/5.0;
    CGFloat viewX = (self.view.width - viewW) / 2.0;
    CGFloat viewY = (self.view.height - viewH) / 2.0;
    
    HTFPopupWindow *positionView = [[HTFPopupWindow alloc] initWithFrame:CGRectMake(viewX, viewY, viewW, viewH)];
    positionView.titleLable.text = @"省份选择";
    positionView.middleView = positionVC.view;
    self.pickerView = positionView;
    
    [self.view addSubview:positionView];
    self.pickerView.valueblock = ^(NSInteger tag){
        if (!tag) {
            [self backViewClick];
        }
    };
    
}
//接受返回的城市
- (void)requestBackCity:(NSNotification *)noti{
    
    //更该模型
    [FHUserViewModel shareUserModel].user.address = noti.object;
    //释放
    [self backViewClick];
    //刷新
    [self.middleView reloadData];
}
//pickerView Window
- (void)creatPickerSelectViewWith:(NSString *)title{
    
    FHBlackView *view = [[FHBlackView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    self.blackView = view;
    //为遮罩添加手势
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backViewClick)];
    [view addGestureRecognizer:gesture];
    
    CGFloat viewW = self.view.width * 2 / 3.0;
    CGFloat viewH = self.view.height / 3.0;
    CGFloat viewX = (self.view.width - viewW) / 2.0;
    CGFloat viewY = (self.view.height - viewH) / 2.0;
    
    //自定义middleView
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    //    picker.backgroundColor = [UIColor blueColor];
    pickerView.tintColor = [UIColor colorWithRed:126/255.0 green:202/255.0 blue:207/255.0 alpha:1];
    [pickerView selectRow:0 inComponent:0 animated:YES];
    
    HTFPopupWindow *selectView  =  [[HTFPopupWindow alloc] initWithFrame:CGRectMake(viewX, viewY, viewW, viewH)];
    selectView.middleView = pickerView;
    selectView.titleLable.text = title;
    self.pickerView = selectView;

    [self.view addSubview:selectView];
    
    //按钮点击动作
    self.pickerView.valueblock = ^(NSInteger tag){
        if (tag) {
             NSString *value = [NSString stringWithFormat:@"%ld%ld%ld.0",(long)self.firstNum,(long)self.secondNum,(long)self.threeNum];
            //解决第一个字符是0的时显示
            if (self.firstNum == 0 && self.secondNum != 0) {
              value = [NSString stringWithFormat:@"%ld%ld.0",(long)self.secondNum,(long)self.threeNum];
            }else if (self.firstNum == 0 && self.secondNum == 0 ){
              value = [NSString stringWithFormat:@"%ld.0",(long)self.threeNum];
            }
            if (self.selectIndex == 0) {
                
                [FHUserViewModel shareUserModel].user.height = value;
                
            }else if (self.selectIndex == 1){
            
                [FHUserViewModel shareUserModel].user.weight = value;
            }else{
            
            }
            [self backViewClick];
            
            //刷新数据
             [self.middleView reloadData];
        }else{
            [self backViewClick];
        }
    };
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 10;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [NSString stringWithFormat:@"%ld",(long)row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    //2.根据列数给相应label赋值
    if(component == 0)
    {
        self.firstNum = row;
    }
    else if(component == 1)
    {
        self.secondNum = row;
    }
    else{
        self.threeNum = row;
    }
}

//手势方法
- (void)backViewClick{
    
    [self.blackView removeFromSuperview];
    [self.pickerView removeFromSuperview];
    self.pickerView = nil;
    self.blackView = nil;
    
    self.selectIndex = false;
    self.firstNum = 0;
    self.secondNum = 0;
    self.threeNum = 0;

}



@end

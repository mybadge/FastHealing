//
//  FHSalvageBasicInfoController.m
//  FastHealing
//
//  Created by 王 on 16/1/21.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHSalvageBasicInfoController.h"
#import "FHSalvageBasicInfoView.h"
#import "FHRelationshipAndCityChosen.h"
#import "FHDiseaseDetailController.h"

@interface FHSalvageBasicInfoController ()<salvageBasicInfoViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) FHRelationshipAndCityChosen *relationshipAndCityChosenView;
@property (strong, nonatomic) FHSalvageBasicInfoView *basicView;
@property (assign, nonatomic) CGRect loc;
@property (strong, nonatomic) UIView *backview;
@property (strong, nonatomic) UIImageView *imageView;
@property (assign, nonatomic) NSInteger chooseViewTag;
@property (strong, nonatomic) NSArray *relationshipArray;
@property (strong, nonatomic) NSMutableArray *chooseViewArray;
@property (strong, nonatomic) NSArray *regionArray;
@property (strong, nonatomic) NSMutableArray *citiesTem;
@property (assign, nonatomic) BOOL isChosenCity;
@property (strong, nonatomic) UIScrollView *backScroll;


@end

@implementation FHSalvageBasicInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"基本信息";

    FHSalvageBasicInfoView *basicView = [FHSalvageBasicInfoView loadSalvageBasicViewWithXib];
    self.basicView = basicView;
    //设置代理
    basicView.delegate = self;
    basicView.title = self.diseaseTitle;
    basicView.name = self.diseaseName;
    
    
    UIScrollView *backScroll = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.backScroll = backScroll;
    [backScroll addSubview:basicView];
    self.view = backScroll;
    backScroll.bounces = NO;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardFramHasChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardFramHasChanged) name:UIKeyboardWillHideNotification object:nil];
//    self.view = basicView;
    
}

//收到键盘弹出通知
- (void)keyboardFramHasChanged:(NSNotification *)notice {
//    NSLog(@"%@",notice);
    NSDictionary *userInfo = notice.userInfo;
    NSLog(@"%@",userInfo);
    CGRect rect = [[userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    if (rect.origin.y > 600) {
        self.backScroll.contentSize = CGSizeMake(3, 800);
    }else {
        self.backScroll.contentSize = CGSizeMake(3, 600);
    }

    
    
//    self.backview.alpha = 0;
    
}


//实现view的代理方法
-(void)showMoreChoicesWithTapView:(UIView *)chooseView {
    //添加遮罩
    UIView *backView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.backview = backView;
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0;
    [self.view addSubview:backView];
    //backview添加手势
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backViewClick)];
    [backView addGestureRecognizer:gesture];
    //保存点击view的tag值
    self.chooseViewTag = chooseView.tag;

    self.relationshipAndCityChosenView.frame = CGRectMake(chooseView.frame.origin.x, chooseView.frame.origin.y + 30, chooseView.frame.size.width, 0);
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(chooseView.frame.origin.x - 5, chooseView.frame.origin.y + 20, chooseView.frame.size.width + 10, 0)];
    
    self.imageView = imageView;
    imageView.image = [UIImage imageNamed:@"popover_background_right"];

    //imageView和tableview的层级关系
    [self.view addSubview:imageView];
    [self.view addSubview:self.relationshipAndCityChosenView];
    self.loc = chooseView.frame;
    //点击改变弹出框的尺寸
    [UIView animateWithDuration:0.25 animations:^{
        backView.alpha = 0.1;
        self.relationshipAndCityChosenView.height = 200;
        imageView.height = 220;
    }];


    [self.relationshipAndCityChosenView reloadData];

    [self.relationshipAndCityChosenView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];;
    
}

//跳转界面
-(void)turnToNextInterface {
    FHDiseaseDetailController *vc = [[FHDiseaseDetailController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


//view的点击手势 取消下拉视图
- (void)backViewClick {
    [UIView animateWithDuration:0.25 animations:^{
        self.imageView.height = 0;
        self.relationshipAndCityChosenView.height = 0;
        self.backview.alpha = 0;
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





//实现tableview的数据源代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (self.chooseViewTag) {
        case 10: {
            [self.chooseViewArray removeAllObjects];
            [self.chooseViewArray addObjectsFromArray:self.relationshipArray];
            return self.relationshipArray.count;
            break;
        }
        case 20: {
            [self.chooseViewArray removeAllObjects];
            [self.regionArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *dic = (NSDictionary *)obj;
                [self.chooseViewArray addObject:dic.allKeys.firstObject];
            }];

            return self.chooseViewArray.count;
            break;
        }
        case 30:{
            if (self.citiesTem.count != 0) {
//                NSLog(@"%@",self.citiesTem);
                [self.chooseViewArray removeAllObjects];
                [self.citiesTem enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSDictionary *dict = (NSDictionary *)obj;
                    [self.chooseViewArray addObject:dict.allKeys.firstObject];
                }];
                
                
                return self.chooseViewArray.count;

            }
            return self.chooseViewArray.count;
        }
        case 40: {
            return self.chooseViewArray.count;
        }
            
        default: {
            return 10;
            break;
        }
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"showMore"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"showMore"];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    cell.textLabel.text = self.chooseViewArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //消除界面
    [self backViewClick];
    

    
    switch (self.chooseViewTag) {
        case 10:{
            self.basicView.relationshipLabel.text = self.chooseViewArray[indexPath.row];
            
            break;
        }
        case 20: {
            //设置省份label
            self.basicView.provinceLabel.text = self.chooseViewArray[indexPath.row];
            //已经选择省份
            NSDictionary *dict = self.regionArray[indexPath.row];
            NSArray *tem = [dict allValues].firstObject;
            
            //保存一个数组,为下一个选项做准备
            [self.citiesTem removeAllObjects];
            [self.citiesTem addObjectsFromArray:tem];
            
//            NSLog(@"%@",tem);
            [self.chooseViewArray removeAllObjects];
            [tem enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *dict = (NSDictionary *)obj;
                [self.chooseViewArray addObject:dict.allKeys.firstObject];
            }];
            
            //打开选择城市交互
            self.basicView.cityView.userInteractionEnabled = YES;
            
            //改变省份需要将城市和区县还原
            self.basicView.cityChosenLabel.text = @"请选择城市";
            self.basicView.districtChosenLabel.text = @"请选择区县";
            
            self.isChosenCity = NO;
            self.basicView.isChosenCity = self.isChosenCity;
  
            break;
        }
        case 30: {
            //设置城市label
            self.basicView.cityChosenLabel.text = self.chooseViewArray[indexPath.row];
            //已经选择城市
            NSDictionary *tem = [self.citiesTem firstObject];
            NSArray *districtTem = tem.allValues.firstObject;
            [self.chooseViewArray removeAllObjects];
            [self.chooseViewArray addObjectsFromArray:districtTem];
//            NSLog(@"%@",self.citiesTem);
            
            //打开选择区县交互
            self.basicView.districtView.userInteractionEnabled = YES;
            
            //改变省份需要将区县还原
            self.basicView.districtChosenLabel.text = @"请选择区县";
            
            self.isChosenCity = NO;
            self.basicView.isChosenCity = self.isChosenCity;
            
            break;
        }
        case 40: {
        
            //设置区县label
            self.basicView.districtChosenLabel.text = self.chooseViewArray[indexPath.row];
            self.isChosenCity = YES;
            self.basicView.isChosenCity = self.isChosenCity;
        }
            
        default:
            break;
    }
    
    
}


//实现信息不完整时候提示的代理方法
-(void)alertInformationNotComplete:(NSString *)infoStr {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:infoStr message:@"信息不完整" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}









//懒加载下拉视图
-(FHRelationshipAndCityChosen *)relationshipAndCityChosenView {
    if (_relationshipAndCityChosenView == nil) {
        FHRelationshipAndCityChosen *table = [[FHRelationshipAndCityChosen alloc]init];
        //tableView背景清除
        table.backgroundColor = [UIColor clearColor];
        
        table.delegate = self;
        table.dataSource = self;
        _relationshipAndCityChosenView = table;
    }
    return _relationshipAndCityChosenView;
}
//懒加载关系数据
-(NSArray *)relationshipArray {
    if (_relationshipArray == nil) {
        NSArray *relationship = @[@"父亲",@"母亲",@"爷爷",@"奶奶",@"其他"];
        _relationshipArray = relationship;
    }
    return _relationshipArray;
}
//懒加载数据数组
-(NSMutableArray *)chooseViewArray {
    if (_chooseViewArray == nil) {
        _chooseViewArray = [NSMutableArray array];
    }
    return _chooseViewArray;
}
//加载地区数组
-(NSArray *)regionArray {
    if (_regionArray == nil) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"areaChosen.plist" ofType:nil];
        _regionArray = [NSArray arrayWithContentsOfFile:path];
    }
    return _regionArray;
}
//加载城市暂存区
-(NSMutableArray *)citiesTem {
    if (_citiesTem == nil) {
        _citiesTem = [NSMutableArray array];
    }
    return _citiesTem;
}




@end

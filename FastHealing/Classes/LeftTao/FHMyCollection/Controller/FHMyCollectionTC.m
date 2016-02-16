//
//  FHMyCollectionTC.m
//  FastHealing
//
//  Created by tao on 16/1/20.
//  Copyright © 2016年 FastHealing. All rights reserved.
//

#import "FHMyCollectionTC.h"
#import "AFNetworking.h"
#import "FHMyCollectionCell.h"
#import "MJExtension.h"
#import "FHMyCollectionModel.h"
#import "FHDoctorMessageVC.h"
#import "MJRefresh.h"


@interface FHMyCollectionTC ()
@property (strong, nonatomic) UIView *testView;
//网络请求
@property(nonatomic, strong) AFHTTPSessionManager *sessionManager;
//模型数组
@property (strong, nonatomic) NSMutableArray *collectionArr;

@property (assign, nonatomic)  NSInteger  page;

@property (assign, nonatomic)  NSInteger  lastPage;
@end

@implementation FHMyCollectionTC

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置nav
    [self setNav];
    //设置cell高
    //self.tableView.rowHeight = 180;
    self.tableView.estimatedRowHeight = 150;
//    [self.tableView setSeparatorInset:UIEdgeInsetsZero ];
//    [self.tableView setLayoutMargins:UIEdgeInsetsZero ];
    //请求数据
    NSInteger page = 1;
    self.page = page;
   // NSNumber *num = [NSNumber numberWithInteger:self.page];
    [self loadDoctorListWith:self.page];
    
    self.tableView.mj_header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page++;
        [self loadDoctorListWith:self.page];
        
    }];
 
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];

}

- (void)loadMoreData{
    self.page--;
            if (self.page <= 0) {
                self.page = 1;
            }
             [self loadDoctorListWith:self.page];
}
//设置导航栏
- (void)setNav{
    //设置导航的左边按钮
    self.title = @"关注的医生";
    //创建导航栏的左边按钮
    //UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
     UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    //[leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"nav_return"] forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //一定要设置大小
    //[leftBtn sizeToFit];
    
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
}

#pragma mark 加载数据

- (void) loadDoctorListWith:(NSInteger)page{
    //page++;
    self.lastPage = page;
    
    NSNumber *num = [NSNumber numberWithInteger:page];
    
    NSString *url = @"http://iosapi.itcast.cn/doctorList.json.php";
    //header 赋值
    //   [sessionManager.requestSerializer setValue:FHLoginToken forHTTPHeaderField:@"login_token"];
    
    //"user_id":1000089,"doctor_id":300000315
    NSDictionary *paramDic = @{@"login_token":FHLoginToken,@"user_id":@(1000089),@"page_size":@(15),@"page":num};
    
    [self.sessionManager POST:url parameters:paramDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {

        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        //获得字典里面的数组
        NSArray *tempArr = jsonDict[@"data"];
        //NSMutableArray *arrM = [[NSMutableArray alloc]initWithCapacity:tempArr.count];
        //遍历数组,做字典转模型
        for (NSDictionary *dict  in tempArr) {
            FHMyCollectionModel *model = [[FHMyCollectionModel alloc]init];
            [model mj_setKeyValues:dict];
            //把模型添加到数组
            //[arrM addObject:model];
            
            if (self.lastPage < self.page) {
                [self.collectionArr insertObject:model atIndex:0];
            }else{
                

                [self.collectionArr insertObject:model atIndex:self.collectionArr.count];
            }
      }
        //self.collectionArr = arrM.copy;
        
       // [self.collectionArr insertObjects:arrM.count atIndexes:0];
        //做字典转模型
//        NSDictionary *dic =jsonDict[@"data"][0];
//        NSLog(@"%@",[dic[@"flower"] class]);
        //更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            //结束刷新
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
}



#pragma mark table数据源方法
//返回多少组
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   // NSLog(@".......%ld",self.collectionArr.count);
    return  self.collectionArr.count;
    //return  self.collectionArr.count;
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //1.创建cell
    FHMyCollectionCell *cell = [FHMyCollectionCell loadCellWith:tableView];
    cell.talkBlockl = ^(UIViewController *vc){
        //vc.title = @"与女神聊天";
        [self.navigationController pushViewController:vc animated:YES];
    };
    
 //2.设置数组
    FHMyCollectionModel *model = self.collectionArr[indexPath.row];
    cell.collectionModel = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //3.返回值
    return  cell;
    
}


#pragma mark tableView的代理
//点击cell的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"点击了关注医生里面的cell");
    //把数据模型传过去
    FHMyCollectionModel *model = self.collectionArr[indexPath.row];
    //NSLog(@"%f",self.tableView.tableFooterView.y);
    //564    458  == 108
#pragma mark 跳到医生简介界面
    FHDoctorMessageVC *messageVC = [[FHDoctorMessageVC alloc]init];
    messageVC.collectionModel = model;
    
    messageVC.actionDocBlock = ^(BOOL isAction){
        if (isAction) {
            [self.collectionArr insertObject:model atIndex:0];
            [self.tableView reloadData];
        }else{
        [self.collectionArr removeObject:model];
            [self.tableView reloadData];
        }
        //self.tableView.mj_footer.hidden = YES;
        
  };
    
    [self.navigationController pushViewController:messageVC animated:YES];

}

//cell的分割线到头
-(void)viewDidLayoutSubviews {

        [self.tableView setSeparatorInset:UIEdgeInsetsZero];

        [self.tableView setLayoutMargins:UIEdgeInsetsZero];

}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    //if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    //}
    //if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    //}
}

//实现导航栏左边按钮的点击事件

- (void)leftBtnClick{
    NSLog(@"点解了左边的按钮");
    [self.navigationController popViewControllerAnimated:YES];
    //[self.navigationController popoverPresentationController];
    //发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dismissVC" object:nil];
}



#pragma mark 懒加载
- (AFHTTPSessionManager *)sessionManager {
    
    if (_sessionManager == nil) {
        _sessionManager = [AFHTTPSessionManager manager];
        
        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSSet *set = [NSSet setWithObjects:@"text/plain", @"text/html", nil];
        //NSLog(@"%@",set);
        
        _sessionManager.responseSerializer.acceptableContentTypes = [_sessionManager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:set];
        
    }
    return _sessionManager;
    
    
}



//模型数组懒加载
//- (NSArray *)collectionArr{
//    if (_collectionArr == nil) {
//        _collectionArr = [NSArray array];
//    }
//    return _collectionArr;
//}

- (NSMutableArray *)collectionArr{
    if (_collectionArr == nil) {
        _collectionArr = [NSMutableArray array];
    }
    return _collectionArr;
}


@end










//
//  FHSickDetailController.m
//  dcDemo
//
//  Created by ZhangZiang on 16/1/20.
//  Copyright © 2016年 ZhangZiang. All rights reserved.
//

#import "FHSickDetailController.h"
#import "FHNetworkTools.h"
#import "Masonry.h"
#import "FHSickDetailCell.h"
#import "FHSelectRefreshControl.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"

@interface FHSickDetailController () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *sickNames;

@property (nonatomic, strong) NSMutableArray *searchResults;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, weak) UIView *searchView;
@property (nonatomic, assign) CGFloat searchViewHeight;

@property (nonatomic, weak) UITextField *textField;

@property (nonatomic, assign) BOOL isFound;

@property (nonatomic, weak) FHSelectRefreshControl *refreshControl;

@property (nonatomic, assign) NSInteger pageNum;

@property (nonatomic, weak) MJRefreshAutoNormalFooter *footer;

@end

@implementation FHSickDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"疾病详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self setupSearchView];
    [self setupTableView];

    [self setupBottomLoadView];
    
    self.pageNum = 1;
    [self postNetwork:self.pageNum isUpForMoreData:NO];
    
}


#pragma mark 设置UI
//设置搜索框
- (void)setupSearchView {
    UIView *searchView = [[UIView alloc]init];
    
    searchView.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
    
    CGFloat searchViewHeight = 35;
    self.searchViewHeight = searchViewHeight;

    
    [self.view addSubview:searchView];
    self.searchView = searchView;
    
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(searchViewHeight);
    }];
    
    //加上图片和textField的
    CGFloat marginForTextField = FHScreenSize.width*0.013;
    CGFloat searchImageWidth = FHScreenSize.width*0.093;
    
    
    //加上textField
    
    
    UITextField *textField = [[UITextField alloc]init];
    textField.backgroundColor = [UIColor whiteColor];
    textField.placeholder = @"请输入查找内容";

    textField.layer.borderWidth = 1;
    textField.layer.cornerRadius = 3;
    
    [searchView addSubview:textField];
    
    self.textField = textField;
    
    
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    //用通知监听textField改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldValueChanged:) name:UITextFieldTextDidChangeNotification object:textField];
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.top.equalTo(searchView).offset(marginForTextField);
        make.bottom.equalTo(searchView).offset(-marginForTextField);
        make.right.equalTo(searchView).with.offset(-marginForTextField);
    }];
    
    UIView *textLeftView = [[UIView alloc]init];

    textLeftView.frame = CGRectMake(marginForTextField, 0, 100, searchViewHeight-2*marginForTextField);
    
    textField.leftView = textLeftView;
    
    UIImageView *searchImageView = [[UIImageView alloc]init];
    
    searchImageView.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
    
    searchImageView.contentMode = UIViewContentModeLeft;
    
    
    [textLeftView addSubview:searchImageView];
    
    
    [searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(textLeftView);
        make.top.equalTo(textLeftView);
        make.width.mas_equalTo(searchImageWidth);

    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
    [textLeftView addSubview:lineView];
    //分割线的约束
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textLeftView);
        make.right.equalTo(textLeftView).offset(-marginForTextField*0.5);
        make.bottom.equalTo(textLeftView).offset(-marginForTextField);
        make.width.mas_equalTo(1);
    }];
    
   
    
}
//移除通知
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)setupTableView {
    
    [self.tableView registerClass:FHSickDetailCell.self forCellReuseIdentifier:@"SickDetailCell"];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.rowHeight = 44;
//    self.tableView.bounces = NO;

    self.tableView.separatorInset = UIEdgeInsetsMake(0,0, 0, 0);
    self.tableView.scrollEnabled = YES;
    
    //设置下拉刷新view
    CGFloat refreshViewHeight = 44;
    
    FHSelectRefreshControl *refreshView = [[FHSelectRefreshControl alloc]init];
    self.refreshControl = refreshView;
    [self.tableView addSubview:refreshView];
    
    [refreshView addTarget:self action:@selector(refreshLoadData:) forControlEvents:UIControlEventValueChanged];
    
    refreshView.frame = CGRectMake(0, -refreshViewHeight, FHScreenSize.width, refreshViewHeight);
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.searchView.mas_bottom);
//        make.top.mas_equalTo(30);
        make.top.equalTo(self.view).offset(self.searchViewHeight);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(FHScreenSize.height-64);//只有把tableView上面的navigationBar等高度减掉才能滚动
    }];
    
    
    
        self.tableView.tableFooterView = [[UIView alloc]init];
    
    [self.view bringSubviewToFront:self.searchView];
}

- (void)setupBottomLoadView {
    

    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self postNetwork:self.pageNum isUpForMoreData:YES];
    }];
    
    self.tableView.mj_footer = footer;
    

}

- (void)refreshLoadData:(FHSelectRefreshControl *)refreshControl {
    
    //这里去网络请求加载更多数据...
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self postNetwork:self.pageNum isUpForMoreData:NO];
        //结束刷新
        [refreshControl endRefresh];
    });
    
}


#pragma mark textField的监听方法

- (void)textFieldValueChanged:(NSNotification *)n {
    [self.searchResults removeAllObjects];
    
    UITextField *textField = [n object];
    
    NSString *string = textField.text;
    
    BOOL hasResult = NO;
    
    for (FHDetailSick *sick in self.sickNames) {
        if ([sick.ci3_name containsString:string]) {
            [self.searchResults addObject:sick];
            
            hasResult = YES;
        }
    }
    
    self.isFound = hasResult;
    
    [self.tableView reloadData];
    

}

#pragma mark - Table view 的数据源和代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (!self.isFound && self.textField.text.length > 0) {
        return 1;
    }
    
    return self.searchResults.count > 0 ? self.searchResults.count : self.sickNames.count;
//    return self.sickNames.count;
}

- (FHSickDetailCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FHSickDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SickDetailCell" forIndexPath:indexPath];
    
   
    if (self.searchResults.count > 0) {
        FHDetailSick *model = self.searchResults[indexPath.row];
        cell.sickModel = model;
        
        cell.textLabel.text = model.ci3_name;
        cell.textLabel.textColor = [UIColor blackColor];
    }
    else if (!self.isFound && self.textField.text.length > 0) {
        cell.textLabel.text = @"并没有找到搜索的结果...";
        cell.textLabel.textColor = [UIColor grayColor];
        }
        else {
            FHDetailSick *model = self.sickNames[indexPath.row];
            cell.sickModel = model;
            
    cell.textLabel.text = model.ci3_name;
            cell.textLabel.textColor = [UIColor blackColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (!self.isFound && self.textField.text.length > 0) {
        return;
    }
    
    if (self.blockSelected) {
        
        FHSickDetailCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        self.blockSelected(cell.sickModel);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark 懒加载

- (NSMutableArray *)sickNames {
    if (_sickNames == nil) {
        _sickNames = [NSMutableArray array];
    }
    return _sickNames;
}

- (NSMutableArray *)searchResults {
    if (_searchResults == nil) {
        _searchResults = [NSMutableArray array];
    }
    return _searchResults;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


#pragma mark 网络请求
- (void)postNetwork :(NSInteger) page isUpForMoreData:(BOOL)isUpForMoreData{
    
    FHNetworkTools *manager = [FHNetworkTools sharedNetworkTools];
    
        NSString *urlStr = @"http://iosapi.itcast.cn/searchCI3List.json.php";
        
        NSDictionary *parameter = @{@"login_token":FHLoginToken,@"keyword":@"",@"ci1_id":@(self.ci1_id),@"page_size":@(15),@"page":@(page)};
    
        [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeNone];
    self.searchView.userInteractionEnabled = NO;
    
        [manager POST:urlStr parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//            NSLog(@"%@",responseObject);
            
            if ([responseObject[@"code"] integerValue] == 1 ) {
                [SVProgressHUD showInfoWithStatus:@"网络错误请重试"];

                return;
            }
            NSNull *null = [[NSNull alloc]init];
            if (responseObject[@"data"] != null) {
                
                NSDictionary *dict = responseObject;
                
                NSArray *arr = [FHDetailSick detailSickWithResponseDict:dict];
                if (isUpForMoreData) {
                    //上拉加载更多
                    
                    [self.sickNames addObjectsFromArray:arr];
                    
                    [self.footer endRefreshingWithNoMoreData];
                    self.tableView.mj_footer.hidden = YES;
                } else {
                    //下拉刷新
                    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, arr.count)];
                    
                    [self.sickNames insertObjects:arr atIndexes:indexSet];
                    
                }
    
                [self.tableView reloadData];

                
                [SVProgressHUD dismiss];
                self.pageNum++;
                
            } else {
               
                [SVProgressHUD showInfoWithStatus:@"没有更多的数据了"];
                
//                [self.footer endRefreshingWithNoMoreData];
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
//                self.tableView.mj_footer.hidden = YES;
            }
            
            self.searchView.userInteractionEnabled = YES;
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);

            [SVProgressHUD showErrorWithStatus:@"网络不稳定..."];
        }];
}
#pragma mark 取消分割线左边的空白间距
-(void)viewDidLayoutSubviews {
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
@end
//
//  CKChooseCityController.m
//  CloudKnows
//
//  Created by  a on 16/8/4.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "CKChooseCityController.h"
#import "CKHomeWeatherController.h"

#import "CKChooseCityCell.h"

#import "CKCityModel.h"
#import "CKNetWorkManager.h"
#import "CKCityManager.h"

@interface CKChooseCityController () <UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) NSArray *hotCityList;
@property (nonatomic, strong) NSMutableArray *searchCityList;

@end

@implementation CKChooseCityController

static NSString *cellID = @"cellIndentifier";

#pragma mark - 构成
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    _searchCityList = [NSMutableArray array];
    _hotCityList = [[CKCityManager shareInstance] getHotCities];
    [self setupNavigationBar];
    [self setupTableView];
//    [self setupHotCities];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)setupNavigationBar {
    self.title = @"添加城市";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_back"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(back)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(cancelSearch)];
    
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"搜索城市";
    _searchBar.tintColor = [UIColor lightGrayColor];
    _searchBar.barStyle = UIBarStyleDefault;
    self.navigationItem.titleView = _searchBar;
}

- (void)setupTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
                                              style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
//    [_tableView registerClass:[CKChooseCityCell class] forCellReuseIdentifier:cellID];
}

//- (void)setupHotCities {
//    _hotCityList = [[CKCityManager shareInstance] getHotCities];
//}

#pragma mark - UITableView 数据源 & 代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _hotCityList.count;
    } else if (section == 1) {
        return _searchCityList.count;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *titleLabel = [UILabel labelWithTextColor:[UIColor whiteColor]
                                      backgroundColor:Color_Theme_Alpha
                                             fontSize:17
                                                lines:1
                                        textAlignment:NSTextAlignmentLeft];
    titleLabel.text = section ? @"   搜索结果" : @"   热搜城市";
    return titleLabel;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CKCityModel *model = indexPath.section == 0 ? _hotCityList[indexPath.row] : _searchCityList[indexPath.row];
    CKChooseCityCell *cell = [CKChooseCityCell cellWithUITableView:tableView CityModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CKCityModel *model = indexPath.section == 0 ? _hotCityList[indexPath.row] : _searchCityList[indexPath.row];
    [[CKCityManager shareInstance] saveCityWithModel:model];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.searchBar resignFirstResponder];
}

#pragma mark - UISearchBarDelegate 

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showWithStatus:@"Searching...."];
    WeakSelf;
    [CKNetWorkManager requestDataWithCityName:searchBar.text Complete:^(id obj) {
        CKCityData *data = (CKCityData *)obj;
        if (data.cityList == nil || data.cityList.count == 0) {
            [SVProgressHUD showErrorWithStatus:@"未找到该城市"];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                weakSelf.searchCityList = data.cityList;
                [weakSelf.tableView reloadData];
            });
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }];
}


#pragma mark - custom 

- (void)back {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)cancelSearch {
    [self.searchBar resignFirstResponder];
}


@end

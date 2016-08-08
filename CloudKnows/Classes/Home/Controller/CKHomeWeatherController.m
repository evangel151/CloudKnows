//
//  CKHomeWeatherController.m
//  CloudKnows
//
//  Created by  a on 16/7/29.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#define AllRandomWallerCount 11

#import "CKHomeWeatherController.h"
#import "CKSettingController.h"
#import "CKChooseCityController.h"
#import "AboutMeController.h"

#import "NullDataView.h"
#import "CKWeatherDetailView.h"
#import "CKHomeWeatherShowCell.h"

#import "CKWeatherData.h"
#import "CKCityModel.h"
#import "CKCityManager.h"
#import "CKNetWorkManager.h"
#import <Masonry.h>

@interface CKHomeWeatherController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
/** 背景壁纸 */
@property (nonatomic, strong) UIImageView *wallerImageView;
/** 操作按钮 - 主要 */
@property (nonatomic, strong) UIButton *operationButton;

@property (nonatomic, strong) NullDataView *nullView;

/********************/

/** 显示/隐藏操作按钮 */
@property (nonatomic, assign) BOOL showOperationButtons;
/** 天气数据列表 */
@property (nonatomic,strong) NSMutableArray *weatherList;
/** 操作按钮数组 */
@property (nonatomic,strong) NSMutableArray *operationBtnArray;

@end

@implementation CKHomeWeatherController

static NSString *cellIdentifier = @"weatherCell";

#pragma mark - 构成
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    _showOperationButtons = NO;
    _weatherList = [NSMutableArray array];
    [self setupTableView];
    [self setupOpertaionButton];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self setupRandomWaller];
    [self setupNullDataView];

}

- (void)setupTableView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT)
                                              style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 88;
    _tableView.hidden = YES;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    // 将操作按钮移至少顶层
    [self.view bringSubviewToFront:_operationButton];
    
    [_tableView registerClass:[CKHomeWeatherShowCell class] forCellReuseIdentifier:cellIdentifier];
}

- (void)setupOpertaionButton {
    _operationButton = [[UIButton alloc] init];
    [_operationButton setImage:[UIImage imageNamed:@"operationBtn"]
                      forState:UIControlStateNormal];
    [_operationButton addTarget:self
                         action:@selector(showButtonsArray)
               forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_operationButton];
    
    [_operationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(64, 64));
        make.bottom.equalTo(self.view.mas_bottom).offset(-100);
    }];
}

//  设置随机壁纸
- (void)setupRandomWaller {
    NSInteger count = arc4random_uniform(AllRandomWallerCount);
    NSString *wallerName = [NSString stringWithFormat:@"waller%zd",count];
    self.wallerImageView.image = [UIImage imageNamed:wallerName];
}

// 设置无数据时显示的界面
- (void)setupNullDataView {
    if (![[CKCityManager shareInstance] hasSelectedCity]) {
        if (!_nullView) {
             NSLog(@"logSomething——————");
            _nullView = [[NullDataView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            [self.view addSubview:_nullView];
        }
        _nullView.hidden = NO;
        _tableView.hidden = YES;
    } else { // 如果不是第一次进入App,显示tableView 并加载数据
        _nullView.hidden = YES;
        _tableView.hidden = NO;
        [self loadNewData];
    }
}


#pragma mark - custom methods (自定义)

- (void)showButtonsArray {
    
    WeakSelf;
    if (_showOperationButtons) {
        _showOperationButtons = NO;
        [weakSelf.operationBtnArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *btn = (UIButton *)obj;
            CGRect frame = weakSelf.operationButton.frame;
            float duration = 0.0;
            [UIView animateWithDuration:0.4 delay:duration options:UIViewAnimationOptionCurveEaseInOut animations:^{
                btn.alpha = 0.0;
                btn.frame = frame;
                btn.transform = CGAffineTransformMakeRotation(M_PI);
            } completion:^(BOOL finished) {
                
            }];
        }];
    }else{
        _showOperationButtons = YES;
        [weakSelf.operationBtnArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *button = (UIButton *)obj;
            //更改后 frame
            CGRect frame = button.frame;
            frame.size.width = frame.size.height = 44;
            //延时
            float duration = 0.0;
            
            switch (idx) {
                case 0: {
                    frame.origin.x -= 50 * sqrt(2);
                    frame.origin.y -= 50 * sqrt(2);
                }
                    break;
                case 1: {
                    frame.origin.y -= 100;
                    duration = 0.1;
                }
                    break;
                case 2: {
                    frame.origin.x += 50 * sqrt(2);
                    frame.origin.y -= 50 * sqrt(2);
                    duration = 0.25;
                }
                    break;
            }
            // 按延迟 将三个button 按顺序依次弹出
            [UIView animateWithDuration:0.4 delay:duration options:UIViewAnimationOptionCurveEaseInOut animations:^{
                button.alpha = 1.0;
                button.frame = frame;
                button.transform = CGAffineTransformMakeRotation(M_PI * 2);
            } completion:nil];
        }];
    }
}

- (void)addCities {
    [self showButtonsArray];
    [self.navigationController pushViewController:[[CKChooseCityController alloc] init]
                                         animated:YES];
}

- (void)settingCities {
    [self showButtonsArray];
    [self.navigationController pushViewController:[[CKSettingController alloc] init]
                                         animated:YES];
}

- (void)aboutMe {
    [self showButtonsArray];
    AboutMeController *meVc = [[AboutMeController alloc] init];
    [self.navigationController pushViewController:meVc
                                         animated:YES];
}


#pragma mark - 数据处理

- (void)loadNewData {
    [_weatherList removeAllObjects];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showWithStatus:@"正在加载"];
    NSArray *arr = [[CKCityManager shareInstance] savedCities];
    if (arr && arr.count > 0) {
        WeakSelf;
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CKCityModel *model = obj;
            [CKNetWorkManager requestDataWithCityID:model.area_id Complete:^(id obj) {
                [weakSelf.weatherList addObject:obj];
                
                if (arr.count == weakSelf.weatherList.count) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.tableView reloadData];
                        [SVProgressHUD dismissWithDelay:0.5];
                    });
                }
            }];
        }];
    } else {
        [SVProgressHUD showErrorWithStatus:@"还没有选择的城市，快去添加一个吧"];
    }
}

#pragma mark - UITableView 数据源 & 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _weatherList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *ID = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//    }
    CKHomeWeatherShowCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    CKWeatherData *data = [_weatherList objectAtIndex:indexPath.row];
    cell.data = data;
    cell.backgroundColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:188/255.0 alpha:0.2];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [CKWeatherDetailView show];
}




#pragma mark - getter

- (UIImageView *)wallerImageView {
    if (!_wallerImageView) {
        _wallerImageView = [[UIImageView alloc] init];
        _wallerImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self.view insertSubview:_wallerImageView atIndex:0];
    }
    return _wallerImageView;
}

//懒加载 操作按钮数组
- (NSMutableArray *)operationBtnArray{
    if (!_operationBtnArray) {
        _operationBtnArray = [[NSMutableArray alloc] init];
        NSArray *imageNameArray = @[@"button_search",@"button_setting",@"button_info"];
        
        for (int i = 0; i < 3; i++) {
            UIButton *button = [[UIButton alloc] initWithFrame:_operationButton.frame];
            button.imageView.contentMode = UIViewContentModeScaleToFill;
            [button setImage:[UIImage imageNamed:imageNameArray[i]] forState:UIControlStateNormal];
            button.alpha = 0.0;
            [_operationBtnArray addObject:button];
            [self.view addSubview:button];
            
            switch (i) {
                case 0: {
                    [button addTarget:self action:@selector(addCities)
                     forControlEvents:UIControlEventTouchUpInside];
                }
                    break;
                case 1: {
                    [button addTarget:self action:@selector(settingCities)
                     forControlEvents:UIControlEventTouchUpInside];
                }
                    break;
                case 2: {
                    [button addTarget:self action:@selector(aboutMe)
                        forControlEvents:UIControlEventTouchUpInside];
                }
                    break;
            }
        }
    }
    return _operationBtnArray;
}

@end

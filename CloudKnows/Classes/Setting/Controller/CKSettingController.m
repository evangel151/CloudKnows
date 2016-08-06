//
//  CKSettingController.m
//  CloudKnows
//
//  Created by  a on 16/8/4.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "CKSettingController.h"
#import "CKChooseCityController.h"
#import "CKSettingCell.h"

#import "CKCityManager.h"
#import "CKCityModel.h"

#import <Masonry.h>

@interface CKSettingController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *wallerImageView;
@property (nonatomic, strong) UIButton *addCityButton;
@property (nonatomic, strong) NSMutableArray *savedCitiesArray;

@end

@implementation CKSettingController

static NSString *cellID = @"settingCell";

#pragma mark - 构造
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    [self setupBasicViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    self.savedCitiesArray = (NSMutableArray *)[[CKCityManager shareInstance] savedCities];
    [_tableView reloadData];
    
    if ([[CKCityManager shareInstance] hasSelectedCity]) {
        _tableView.hidden = NO;
        _addCityButton.hidden = YES;
    } else {
        _tableView.hidden = YES;
        _addCityButton.hidden = NO;
    }
}


- (void)setupTableView {
    CGFloat marginTop = 84;
    CGFloat marginBottom = 54;
    CGFloat padding = 5;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 84 + padding , SCREEN_WIDTH, SCREEN_HEIGHT - marginTop -marginBottom - padding)
                                              style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    [_tableView.layer setNeedsLayout];
    
    [_tableView registerClass:[CKSettingCell class] forCellReuseIdentifier:cellID];
}

- (void)setupBasicViews {
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    // 壁纸
    self.wallerImageView.image = [UIImage imageNamed:@"Detail"];
    
    // headerLabel
    UILabel *headerLabel = [UILabel labelWithTextColor:[UIColor whiteColor]
                                       backgroundColor:LJregular(0.5, 0.5, 0.5, 0.2)
                                              fontSize:19
                                                 lines:1
                                         textAlignment:NSTextAlignmentCenter];
    headerLabel.text = @"点击X号删除对应的城市";
    [self.view addSubview:headerLabel];
    
    [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(40);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 40, 44));
    }];
    
    // bottomView
    UIButton *backButton = [UIButton buttonWithBackgroundColor:Color_Theme_Alpha
                                                         title:@"返回上一页"
                                                      fontSize:19
                                                    titleColor:[UIColor whiteColor]
                                                        target:self
                                                        action:@selector(backDidClick)
                                                 clipsToBounds:YES];
    [self.view addSubview:backButton];
    
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).offset(-10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 40, 44));
    }];
    
    // addCityButton
    [self.view addSubview:self.addCityButton];
    [_addCityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    self.addCityButton.hidden = YES;
}


#pragma mark - UITableView 数据源 & 代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_savedCitiesArray && _savedCitiesArray.count > 0 ) {
        return _savedCitiesArray.count;
    }
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CKCityModel *city = [_savedCitiesArray objectAtIndex:indexPath.row];
    CKSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.city = city;
    
    WeakSelf;
    __weak CKSettingCell *weakCell = cell;
    cell.block = ^(NSString *cityID) {
        [weakSelf.savedCitiesArray removeObjectAtIndex:indexPath.row];
        
        // 删除后同步savedCities
        NSMutableArray *arr = [NSMutableArray array];
        [weakSelf.savedCitiesArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:(CKCityModel *)obj];
            [arr addObject:data];
        }];
        [[NSUserDefaults standardUserDefaults] setObject:arr forKey:UserSelectedCityListKey];
        
        // 执行动画
        dispatch_async(dispatch_get_main_queue(), ^{
            
           [UIView animateWithDuration:0.5
                                 delay:0.0
                usingSpringWithDamping:0.8
                 initialSpringVelocity:0.8
                               options:UIViewAnimationOptionCurveEaseInOut animations:^{
                                   
                                   weakCell.transform = CGAffineTransformMakeScale(0.3, 0.3);
                                   
           } completion:^(BOOL finished) {
               
               if (finished) {
                   [weakSelf.tableView deleteRowsAtIndexPaths:@[indexPath]
                                             withRowAnimation:UITableViewRowAnimationFade];
                   
                   // 回到主线程刷新界面
                   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                       
                       if (![[CKCityManager shareInstance] hasSelectedCity]) { // all cells deleted
                           weakSelf.tableView.hidden = YES;
                           weakSelf.addCityButton.hidden = NO;
                       } else { // some cells left
                           [weakSelf.tableView reloadData];
                       }
                       
                   });
               }
           }];
        });
    };
    
    return cell;
}



#pragma mark - costom
- (void)backDidClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addCityButtonDidClicked {
    CKChooseCityController *choose = [[CKChooseCityController alloc] init];
    [self.navigationController pushViewController:choose animated:YES];
}

#pragma mark -  getter
- (UIImageView *)wallerImageView {
    if (!_wallerImageView) {
        _wallerImageView = [[UIImageView alloc] init];
        _wallerImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
        [self.view insertSubview:_wallerImageView atIndex:0];
    }
    return _wallerImageView;
}

- (NSMutableArray *)savedCitiesArray {
    if (!_savedCitiesArray) {
        _savedCitiesArray = [NSMutableArray array];
    }
    return _savedCitiesArray;
}

- (UIButton *)addCityButton {
    if (!_addCityButton) {
        _addCityButton = [UIButton buttonWithBackgroundColor:Color_Theme_Alpha
                                                       title:@"前往添加"
                                                    fontSize:19
                                                  titleColor:[UIColor whiteColor]
                                                      target:self
                                                      action:@selector(addCityButtonDidClicked)
                                               clipsToBounds:YES];
    }
    return _addCityButton;
}



@end

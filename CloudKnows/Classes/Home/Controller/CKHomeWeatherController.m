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

#import "AFNetWorkingTool.h"
#import <Masonry.h>

@interface CKHomeWeatherController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
/** 背景壁纸 */
@property (nonatomic, strong) UIImageView *wallerImageView;
/** 操作按钮 - 主要 */
@property (nonatomic, strong) UIButton *operationButton;

/********************/

/** 显示/隐藏操作按钮 */
@property (nonatomic, assign) BOOL showOperationButtons;
/** 天气数据列表 */
@property (nonatomic,strong) NSMutableArray *weatherList;
/** 操作按钮数组 */
@property (nonatomic,strong) NSMutableArray *operationBtnArray;

@end

@implementation CKHomeWeatherController

#pragma mark - 构成
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    _showOperationButtons = NO;
    
    [self setupTableView];
    [self setupOpertaionButton];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self setupRandomWaller];
    [self setUpNullDataView];
}

- (void)setupTableView {
    
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
- (void)setUpNullDataView {
    
}


#pragma mark - custom methods (自定义)


- (void)showButtonsArray {
    
    WeakSelf;
    if (_showOperationButtons) {
        _showOperationButtons = NO;
        [self.operationBtnArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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
        [self.operationBtnArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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
    
}

#pragma mark - UITableView 数据源 & 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     NSLog(@"即将弹出WeatherDetail——————");
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
            [button setBackgroundColor:LJRandomColor];
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

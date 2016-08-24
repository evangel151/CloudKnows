//
//  CKWeatherDetailView.m
//  CloudKnows
//
//  Created by  a on 16/8/7.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "CKWeatherDetailView.h"
#import "CKWeatherDetailCell.h"

#import "CKCityModel.h"
#import "CKWeatherData.h"
#import "CKWeatherModel.h"

#import <Masonry.h>

@interface CKWeatherDetailView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIImageView *waller;
@property (nonatomic, strong) UILabel *cityNameLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *temperatureLabel;
@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *weatherList;
@property (nonatomic, strong) CKTodayWeather *today;

@property (nonatomic, assign) NSInteger todayIndex;
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation CKWeatherDetailView

static NSString *detailCellIdentifier = @"detailCellID";

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        CGFloat margin = 30; // 左右间隙
        
        // 壁纸
        _waller = [[UIImageView alloc] init];
        _waller.image = [UIImage imageNamed:@"aboutMe"];
        [self insertSubview:_waller atIndex:0];
        
        // 城市名
        _cityNameLabel = [UILabel labelWithTextColor:[UIColor whiteColor]
                                     backgroundColor:[UIColor clearColor]
                                            fontSize:31
                                               lines:1
                                       textAlignment:NSTextAlignmentCenter];
        _cityNameLabel.text = @"城市名 : 北京";
        [self addSubview:_cityNameLabel];
        
        
        _backButton = [[UIButton alloc] init];
        [_backButton setImage:[UIImage imageNamed:@"deleteButton"] forState:UIControlStateNormal];
        [_backButton setImage:[UIImage imageNamed:@"deleteButton"] forState:UIControlStateSelected];
        [_backButton addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backButton];
        
        _temperatureLabel = [UILabel labelWithTextColor:[UIColor whiteColor]
                                        backgroundColor:[UIColor clearColor]
                                               fontSize:21
                                                  lines:1
                                          textAlignment:NSTextAlignmentCenter];
        _temperatureLabel.text = @"今日气温 ： ℃ ~ ℃";
        [self addSubview:_temperatureLabel];
        
        _dateLabel = [UILabel labelWithTextColor:[UIColor whiteColor]
                                 backgroundColor:[UIColor clearColor]
                                        fontSize:19
                                           lines:1
                                   textAlignment:NSTextAlignmentCenter];
        _dateLabel.text = @"201X年X月X日, 星期X";
        [self addSubview:_dateLabel];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(margin, 264, SCREEN_WIDTH - margin * 2, SCREEN_HEIGHT - 284)
                                                  style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 115;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:[CKWeatherDetailCell class] forCellReuseIdentifier:detailCellIdentifier];
        [self addSubview:_tableView];
        
        [_waller mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];

        [_cityNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(margin + 40);
            make.right.equalTo(self.mas_right).offset(-margin - 40);
            make.top.equalTo(self.mas_top).offset(64);
            make.height.equalTo(@(40));
        }];
        
        [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.centerY.equalTo(self.cityNameLabel.mas_centerY);
            make.left.equalTo(self.cityNameLabel.mas_right);
        }];
        
        [_temperatureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(margin);
            make.right.equalTo(self.mas_right).offset(-margin);
            make.top.equalTo(self.cityNameLabel.mas_bottom).offset(20);
            make.height.equalTo(@(40));
        }];
        
        [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(margin);
            make.right.equalTo(self.mas_right).offset(-margin);
            make.top.equalTo(self.temperatureLabel.mas_bottom).offset(20);
            make.height.equalTo(@(40));
        }];
        
    }
    return self;
}



+ (void)showWithWeatherData:(CKWeatherData *)data {
    CKWeatherDetailView *detailView = [[CKWeatherDetailView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    detailView.alpha = 0.0;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:detailView];
    
    
    detailView.weatherList = [NSMutableArray array];
    [detailView.weatherList addObjectsFromArray:data.historyArray];
    
    detailView.todayIndex = data.historyArray.count;
    
    [detailView.weatherList addObject:data.today];
    detailView.today = data.today;
    
    [detailView.weatherList addObjectsFromArray:data.forecastArray];
    
    [detailView buildUIWithWeatherData:data];
    
    
    [UIView animateWithDuration:0.5 animations:^{
        detailView.alpha = 1.0;
    }];
}

- (void)buildUIWithWeatherData:(CKWeatherData *)data {
    
    _cityNameLabel.text = data.cityName;
    _temperatureLabel.text = [NSString stringWithFormat:@"当前气温: %@",data.today.curTemp];;
    CKWeatherModel *model = [_weatherList objectAtIndex:data.historyArray.count];
    _dateLabel.text = [NSString stringWithFormat:@"%@ %@",model.date,model.week];
}

+ (void)show {
    CKWeatherDetailView *detailView = [[CKWeatherDetailView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    detailView.alpha = 0.0;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:detailView];
    
    [UIView animateWithDuration:0.5 animations:^{
        detailView.alpha = 1.0;
    }];
}

#pragma mark - UITableView 数据源 代理 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = self.weatherList.count;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CKWeatherDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:detailCellIdentifier];
    CKWeatherModel *model = [_weatherList objectAtIndex:indexPath.row];
    cell.model = model;
//    CKWeatherModel *todayModel = [_weatherList objectAtIndex:7];
//    if ([model.date isEqualToString:todayModel.date]) {
//        cell.dateLabel.backgroundColor = [UIColor orangeColor];
//    }
    
    return cell;
}

#pragma mark - custom
// 移除
- (void)remove {
    // 将伪modal弹出方式换成淡化方式
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    
}


@end

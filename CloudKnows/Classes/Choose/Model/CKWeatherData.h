//
//  CKWeatherData.h
//  CloudKnows
//
//  Created by  a on 16/8/8.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CKWeatherModel.h"


@interface CKWeatherData : NSObject

/// 城市名称
@property (nonatomic,strong) NSString *cityName;
/// 城市ID
@property (nonatomic,strong) NSString *cityID;

/// 今日天气
@property (nonatomic,strong) CKTodayWeather *today;

/////// 预测天气
@property (nonatomic,strong) NSMutableArray *forecastArray;

/////// 历史数据
@property (nonatomic,strong) NSMutableArray *historyArray;

+ (instancetype)initWithString:(NSString *)jsonString;

@end

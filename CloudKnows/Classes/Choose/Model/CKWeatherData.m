//
//  CKWeatherData.m
//  CloudKnows
//
//  Created by  a on 16/8/8.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "CKWeatherData.h"
#import "CKWeatherModel.h"
#import <MJExtension.h>

@implementation CKWeatherData
+ (instancetype)initWithString:(NSString *)jsonString{
    
    [CKWeatherData mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"cityName" : @"retData.city",
                 @"cityID" : @"retData.cityid",
                 @"today" : @"retData.today",
                 @"forecastArray" : @"retData.forecast",
                 @"historyArray" : @"retData.history",
                 };
    }];
    
    [CKWeatherData mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"forecastArray" : @"CKWeatherModel",
                 @"historyArray" : @"CKWeatherModel",
                 };
    }];
    
//    [CKWeatherModel setup];
    CKWeatherData *weatherData = [[CKWeatherData alloc] init];
    weatherData.forecastArray = [NSMutableArray array];
    weatherData.historyArray = [NSMutableArray array];
    weatherData = [CKWeatherData mj_objectWithKeyValues:jsonString];

    return weatherData;
}



@end

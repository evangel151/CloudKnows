//
//  CKWeatherModel.m
//  CloudKnows
//
//  Created by  a on 16/8/7.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "CKWeatherModel.h"

#import <MJExtension.h>

@implementation CKWeatherModel

+ (instancetype)toWeatherModelWithData:(id)obj{
    CKWeatherModel *model = [[CKWeatherModel alloc] init];
    
    NSDictionary *dict = [obj mj_keyValues];
    
    model = [CKWeatherModel mj_objectWithKeyValues:dict];
    
    return model;
}

@end



@implementation CKTodayWeather



@end

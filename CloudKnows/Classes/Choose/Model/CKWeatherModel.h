//
//  CKWeatherModel.h
//  CloudKnows
//
//  Created by  a on 16/8/7.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CKWeatherModel : NSObject

/// 日期
@property (nonatomic,strong) NSString *date;
/// 星期
@property (nonatomic,strong) NSString *week;
/// 风向
@property (nonatomic,strong) NSString *fengxiang;
/// 风力
@property (nonatomic,strong) NSString *fengli;
/// 最高温
@property (nonatomic,strong) NSString *hightemp;
/// 最低温
@property (nonatomic,strong) NSString *lowtemp;
/// 天气类型
@property (nonatomic,strong) NSString *type;

+ (instancetype)toWeatherModelWithData:(id)obj;

@end

@interface CKTodayWeather : CKWeatherModel

@property (nonatomic, strong) NSString *curTemp;

@end

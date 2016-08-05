//
//  CKCityManager.h
//  CloudKnows
//
//  Created by  a on 16/8/4.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CKCityModel;

@interface CKCityManager : NSObject

+ (instancetype)shareInstance;

/** 是否已有选择的城市 */
- (BOOL)hasSelectedCity;

/** 初始化热门城市(8个) */
- (void)setupHotCities;

/** 返回热门城市列表 */
- (NSArray *)getHotCities;

/** 存储选定的城市 */
- (void)saveCityWithModel:(CKCityModel *)model;

/** 返回已经选定的城市 */
- (NSArray *)savedCities;

@end

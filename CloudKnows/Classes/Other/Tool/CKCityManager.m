//
//  CKCityManager.m
//  CloudKnows
//
//  Created by  a on 16/8/4.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "CKCityManager.h"
#import "CKCityModel.h"
#import "CKChooseCityController.h"

@interface CKCityManager ()

@property (nonatomic, strong) NSMutableArray *hotCities;

@end

@implementation CKCityManager

static CKCityManager *manager;

// 单例，并添加同步锁，防止多线程同时访问
+ (instancetype)shareInstance {
    @synchronized(self) {
        if (!manager) {
            manager = [[CKCityManager alloc] init];
            manager.hotCities = [NSMutableArray arrayWithCapacity:8];
        }
    }
    return manager;
}

- (BOOL)hasSelectedCity {
    NSArray *selectedCityList = [[NSUserDefaults standardUserDefaults] objectForKey:UserSelectedCityListKey];
    if (selectedCityList && selectedCityList.count > 0) {
        return YES;
    }
    return NO;
}

- (void)setupHotCities {
    NSMutableArray *hotCitiesArray = [NSMutableArray arrayWithCapacity:8];
    NSArray *cityNameArray = [NSArray arrayWithObjects:@"北京",@"上海",@"西安",@"广州",@"深圳",@"南京",@"太原",@"杭州", nil];
    NSArray *cityIDArray = [NSArray arrayWithObjects:@"101010100",@"101020100",@"101110101",@"101280101",@"101280601",@"101190101",@"101100101" ,@"101210101",nil];
    
    if (_hotCities == nil || _hotCities.count == 0) {
        for (int i = 0; i < cityNameArray.count; i++) {
            CKCityModel *model = [[CKCityModel alloc] init];
            model.province_cn  = @"";
            model.name_cn      = @"";
            model.name_en      = @"";
            model.district_cn  = cityNameArray[i];
            model.area_id      = cityIDArray[i];
            
            // 自定义模型需要首先使用NSData进行转存，然后才可以使用NSUserDefaults永久化保存
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
            [hotCitiesArray addObject:data];
        }
    }
    [[NSUserDefaults standardUserDefaults] setObject:hotCitiesArray forKey:HotCitiesKey];
    [[NSUserDefaults standardUserDefaults] synchronize]; // 立即同步
}

- (NSArray *)getHotCities {
    
    WeakSelf;
    if (_hotCities == nil || _hotCities.count == 0) {
        NSArray *hotCitiesArray = [[NSUserDefaults standardUserDefaults] objectForKey:HotCitiesKey];
        [hotCitiesArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CKCityModel *model = [[CKCityModel alloc] init];
            model = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
            [weakSelf.hotCities addObject:model];
        }];
    }
    
    return _hotCities;
}

- (void)saveCityWithModel:(CKCityModel *)model {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setFadeOutAnimationDuration:1];
    // 先从本地获取保存的城市列表
    NSMutableArray *savedArray = [[NSUserDefaults standardUserDefaults] objectForKey:UserSelectedCityListKey];
    __block BOOL isHasSaved = NO;
    // 1. 已经保存过该城市
    if (savedArray && savedArray.count > 0) {
        [savedArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CKCityModel *cityModel = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
            if ([cityModel.area_id isEqualToString:model.area_id]) {
                
                [SVProgressHUD showSuccessWithStatus:@"该城市您已经保存过了哦~"];
                
                isHasSaved = YES;
                *stop = YES;
            }
        }];
    }
    // 2. 没有保存过该城市
    if (!isHasSaved) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
        if (savedArray.count == 0) {
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
            [[NSUserDefaults standardUserDefaults] setObject:array forKey:UserSelectedCityListKey];
        }
        
        NSMutableArray *array = [NSMutableArray array];
        [array addObjectsFromArray:savedArray];
        [array addObject:data];
        [[NSUserDefaults standardUserDefaults] setObject:array forKey:UserSelectedCityListKey];
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}

- (NSArray *)savedCities {
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:UserSelectedCityListKey];
    if (array && array.count > 0) {
        NSMutableArray *cities = [NSMutableArray array];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CKCityModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
            [cities addObject:model];
        }];
        return cities;
    }
    return nil;
}

@end

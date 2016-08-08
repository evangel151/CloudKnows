//
//  CKCityModel.m
//  CloudKnows
//
//  Created by  a on 16/8/4.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "CKCityModel.h"
#import <MJExtension.h>

#define ProvinceName    @"ProvinceName"
#define DistrictName    @"DistrictName"
#define NameCN          @"NameCN"
#define NameEN          @"NameEN"
#define AreaID          @"AreaID"

@implementation CKCityModel
//- MARK:自定义类 无法存储到 NSUserDefaults里面，所以先转换为NSData
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _province_cn = [coder decodeObjectForKey:@"ProvinceName"];
        _district_cn = [coder decodeObjectForKey:@"DistrictName"];
        _name_cn     = [coder decodeObjectForKey:@"NameCN"];
        _name_en     = [coder decodeObjectForKey:@"NameEN"];
        _area_id     = [coder decodeObjectForKey:@"AreaID"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_province_cn forKey:@"ProvinceName"];
    [aCoder encodeObject:_district_cn forKey:@"DistrictName"];
    [aCoder encodeObject:_name_cn forKey:@"NameCN"];
    [aCoder encodeObject:_name_en forKey:@"NameEN"];
    [aCoder encodeObject:_area_id forKey:@"AreaID"];
}

+ (void)setup {
    [CKCityModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"province_cn" : @"province_cn",
                 @"district_cn" : @"district_cn",
                 @"name_cn" : @"name_cn",
                 @"name_en" : @"name_en",
                 @"area_id" : @"area_id",
                 };
    }];
}

@end

@implementation CKCityData

+ (CKCityData *)initWithString:(NSString *)JSONString {
    [CKCityModel setup];
    
    // 使用MJExtension进行字典映射
    [CKCityData mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"cityList" : @"retData",
                 };
    }];
    
    [CKCityData mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"cityList" : @"CKCityModel",
                 };
    }];
    
    CKCityData *data = [CKCityData mj_objectWithKeyValues:JSONString];
    return data;
}

@end

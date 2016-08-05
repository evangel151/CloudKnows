//
//  CKCityModel.h
//  CloudKnows
//
//  Created by  a on 16/8/4.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CKCityModel : NSObject <NSCoding>

/// 省
@property (nonatomic,strong) NSString  *province_cn;
/// 市
@property (nonatomic,strong) NSString *district_cn;
/// 区、县
@property (nonatomic,strong) NSString *name_cn;
/// 城市拼音
@property (nonatomic,strong) NSString *name_en;
/// 城市编码
@property (nonatomic,strong) NSString *area_id;

@end

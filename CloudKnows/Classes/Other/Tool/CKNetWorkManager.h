//
//  CKNetWorkManager.h
//  CloudKnows
//
//  Created by  a on 16/8/7.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompleteBlock)(id obj);

@interface CKNetWorkManager : NSObject

+ (void)requestDataWithCityID:(NSString *)cityID Complete:(CompleteBlock)completeBlock;


+ (void)requestDataWithCityName:(NSString *)cityName Complete:(CompleteBlock)completeBlock;

@end

//
//  CKNetWorkManager.m
//  CloudKnows
//
//  Created by  a on 16/8/7.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "CKNetWorkManager.h"
#import "AFNetWorkingTool.h"

#import "CKWeatherData.h"
#import "CKCityModel.h"

@implementation CKNetWorkManager

+ (void)requestDataWithCityID:(NSString *)cityID Complete:(CompleteBlock)completeBlock {
    
//    [AFNetWorkingTool GET:@"" params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//    } fail:^(NSURLSessionDataTask *task, NSError *error) {
//        
//    }];
    // API接口表述不明确，改用NSURLSession
    NSString *httpArg = [NSString stringWithFormat:@"cityname=?&cityid=%@",cityID];
    NSString *urlStr = [NSString stringWithFormat:@"%@?%@",BaiduApiRequest,httpArg];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    [request addValue:BaiduApiKey forHTTPHeaderField:@"apikey"];
    
    // - MARK: NSURLSession方法
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
        } else {
            NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            //解析json
            CKWeatherData *data = [CKWeatherData initWithString:responseString];
            
            if (completeBlock != nil) {
                completeBlock(data);
            }
            
        }
    }];
    [task resume];
    
}

+ (void)requestDataWithCityName:(NSString *)cityName Complete:(CompleteBlock)completeBlock {
    
//    [AFNetWorkingTool GET:@"" params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//    } fail:^(NSURLSessionDataTask *task, NSError *error) {
//        
//    }];
    NSString *httpArg = [NSString stringWithFormat:@"cityname=%@",cityName];
    NSString *urlStr = [NSString stringWithFormat:@"%@?%@",BaiduApiCityList,httpArg];
    //此处 城市名称为中文 需要先将中文转换成utf-8编码
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    [request addValue:BaiduApiKey forHTTPHeaderField:@"apikey"];
    
    // - MARK: NSURLSession方法
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Httperror: %@    %ld", error.localizedDescription, error.code);
        } else {
            NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            //解析json
            CKCityData *data = [CKCityData initWithString:responseString];
            
            if (completeBlock != nil) {
                completeBlock(data);
            }
        }
    }];
    [task resume];
}


@end

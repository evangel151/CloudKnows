//
//  UIImage+Extension.m
//  CloudKnows
//
//  Created by  a on 16/8/8.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (instancetype)returnImageWithWeatherType:(NSString *)type {
    
    NSString *weatherImageName = @"";
    
    if ([type containsString:@"雨"]) {
        weatherImageName = @"weatherIcon_middleRain";
        
        if ([type containsString:@"雪"]) {
            weatherImageName = @"weatherIcon_middleSnow"; // 雨夹雪
        }else if ([type containsString:@"雷"]){
            weatherImageName = @"weatherIcon_hunderShower"; // 雷阵雨
        }
    }else if ([type containsString:@"晴"]){
        weatherImageName = @"weatherIcon_sunshine";
    }else if ([type containsString:@"阴"]){
        weatherImageName = @"weatherIcon_overcastSky";
    }else if ([type containsString:@"多云"]){
        weatherImageName = @"weatherIcon_cloudy";
    }else if ([type containsString:@"雪"]){
        weatherImageName = @"weatherIcon_heavySnow";
    }else if ([type containsString:@"霾"]){
        weatherImageName = @"weatherIcon_haze";
    }else if ([type containsString:@"尘"] ||[type containsString:@"沙"]){
        weatherImageName = @"weatherIcon_blowingSand";
    }
    
    return [UIImage imageNamed:weatherImageName];
}

@end

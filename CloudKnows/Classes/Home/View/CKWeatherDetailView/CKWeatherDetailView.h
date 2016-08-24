//
//  CKWeatherDetailView.h
//  CloudKnows
//
//  Created by  a on 16/8/7.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CKWeatherData;
@interface CKWeatherDetailView : UIView

+ (void)show;

+ (void)showWithWeatherData:(CKWeatherData *)data;

@end

//
//  CKWeatherDetailCell.h
//  CloudKnows
//
//  Created by  a on 16/8/9.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CKWeatherModel;

@interface CKWeatherDetailCell : UITableViewCell

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) CKWeatherModel *model;

@end

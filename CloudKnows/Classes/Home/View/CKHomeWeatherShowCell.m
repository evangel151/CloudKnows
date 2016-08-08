//
//  CKHomeWeatherShowCell.m
//  CloudKnows
//
//  Created by  a on 16/8/4.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "CKHomeWeatherShowCell.h"

#import "CKWeatherData.h"
#import "CKWeatherModel.h"
#import "CKCityModel.h"

#import <Masonry.h>

@interface CKHomeWeatherShowCell ()


@property (nonatomic, strong) UIImageView *weatherIcon; // 天气类型图片
@property (nonatomic, strong) UILabel *currentTempLabel; // 当前气温
@property (nonatomic, strong) UILabel *areaLabel; // 所在地区
@property (nonatomic, strong) UILabel *weatherTypeLabel; // 天气概况
@property (nonatomic, strong) UILabel *L_H_TempLabel; // 最低~最高气温
@end

@implementation CKHomeWeatherShowCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _weatherIcon = [[UIImageView alloc] init];
        _weatherIcon.backgroundColor = LJregular(255, 255, 255, 0.3);
        _weatherIcon.layer.cornerRadius = 5;
        [self.contentView addSubview:_weatherIcon];
        
        _currentTempLabel = [UILabel labelWithTextColor:[UIColor whiteColor]
                                        backgroundColor:[UIColor clearColor]
                                               fontSize:19
                                                  lines:1
                                          textAlignment:NSTextAlignmentLeft];
        
        [self.contentView addSubview:_currentTempLabel];
        
        _areaLabel = [UILabel labelWithTextColor:[UIColor whiteColor]
                                 backgroundColor:[UIColor clearColor]
                                        fontSize:18
                                           lines:1
                                   textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_areaLabel];
        
        _weatherTypeLabel = [UILabel labelWithTextColor:[UIColor whiteColor]
                                        backgroundColor:[UIColor clearColor]
                                               fontSize:18
                                                  lines:1
                                          textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_weatherTypeLabel];
        
        _L_H_TempLabel = [UILabel labelWithTextColor:[UIColor whiteColor]
                                     backgroundColor:[UIColor clearColor]
                                            fontSize:17
                                               lines:1
                                       textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_L_H_TempLabel];
        
        [_weatherIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
            make.width.equalTo(@(68));
        }];
        
        [_currentTempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.weatherIcon.mas_right).offset(30);
            make.right.equalTo(self.contentView.mas_right);
            make.top.equalTo(self.contentView.mas_top).offset(8);
            make.height.equalTo(@(18));
        }];
        
        [_areaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.currentTempLabel.mas_left);
            make.top.equalTo(self.currentTempLabel.mas_bottom);
            make.size.mas_equalTo(self.currentTempLabel);
        }];
        
        [_weatherTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.currentTempLabel.mas_left);
            make.top.equalTo(self.areaLabel.mas_bottom);
            make.size.mas_equalTo(self.currentTempLabel);
        }];
        
        [_L_H_TempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.currentTempLabel.mas_left);
            make.top.equalTo(self.weatherTypeLabel.mas_bottom);
            make.size.mas_equalTo(self.currentTempLabel);
        }];
    }
    return self;
}

- (void)setData:(CKWeatherData *)data {
    
    self.weatherIcon.image = [UIImage returnImageWithWeatherType:data.today.type];
    self.currentTempLabel.text = data.today.curTemp;
    self.areaLabel.text = data.cityName;
    self.weatherTypeLabel.text = data.today.type;
    self.L_H_TempLabel.text = [NSString stringWithFormat:@"最低气温 %@℃ ~ 最高气温%@℃",data.today.lowtemp,data.today.hightemp];
}



//+ (instancetype)cellWithTableview:(UITableView *)tableView WeatherData:(CKWeatherData *)data{
//    static NSString *cellID = @"WeatherCellIdentifier";
//    CKHomeWeatherShowCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    if (!cell) {
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"WeatherCell" owner:nil options:nil] lastObject];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//    //1.根据天气类型更改 imgView图片
////    [cell setupWeatherTypeImage:data.today.type];
//    //2.更新天气显示数据
//    cell.currentTempLabel.text = data.today;
//    cell.districtNameLabel.text = data.cityName;
//    cell.weatherTypeLabel.text = data.today.type;
//    cell.HighOrLowTempLabel.text = [NSString stringWithFormat:@"Max.%@ - Min.%@",data.today.hightemp,data.today.lowtemp];
//    
//    return cell;
//}


@end

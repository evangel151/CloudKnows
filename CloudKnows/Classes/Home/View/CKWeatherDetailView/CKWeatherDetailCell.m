//
//  CKWeatherDetailCell.m
//  CloudKnows
//
//  Created by  a on 16/8/9.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "CKWeatherDetailCell.h"
#import "CKWeatherData.h"

#import <Masonry.h>

@interface CKWeatherDetailCell ()
//@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIImageView *weatherTypeIcon;
@property (nonatomic, strong) UILabel *weatherTypeLabel;
@property (nonatomic, strong) UIImageView *windPowerIcon;
@property (nonatomic, strong) UILabel *windPowerLabel;
@property (nonatomic, strong) UIImageView *windDirectIcon;
@property (nonatomic, strong) UILabel *windDirectLabel;
@property (nonatomic, strong) UIImageView *L_H_tempIcon;
@property (nonatomic, strong) UILabel *L_H_tempLabel;
@end

@implementation CKWeatherDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];// 盐城

        _weatherTypeIcon = [[UIImageView alloc] init];
        _weatherTypeIcon.layer.cornerRadius = 5;
        _weatherTypeIcon.backgroundColor = LJregular(255, 255, 255, 0.5);
        [self.contentView addSubview:_weatherTypeIcon];
        
        _windPowerIcon = [[UIImageView alloc] init];
        _windPowerIcon.image = [UIImage imageNamed:@"风力"];
        [self.contentView addSubview:_windPowerIcon];
        
        _windDirectIcon = [[UIImageView alloc] init];
        _windDirectIcon.image = [UIImage imageNamed:@"风向"];
        [self.contentView addSubview:_windDirectIcon];
        
        _L_H_tempIcon = [[UIImageView alloc] init];
        _L_H_tempIcon.image = [UIImage imageNamed:@"温度"];
        [self.contentView addSubview:_L_H_tempIcon];
        
        _dateLabel = [UILabel labelWithTextColor:[UIColor whiteColor]
                                 backgroundColor:Color_Theme_Alpha
                                        fontSize:17
                                           lines:1
                                   textAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_dateLabel];
        
        _weatherTypeLabel = [UILabel labelWithTextColor:[UIColor whiteColor]
                                        backgroundColor:[UIColor clearColor]
                                               fontSize:17
                                                  lines:1
                                          textAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_weatherTypeLabel];
        
        _windPowerLabel = [UILabel labelWithTextColor:[UIColor whiteColor]
                                      backgroundColor:[UIColor clearColor]
                                             fontSize:17
                                                lines:1
                                        textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_windPowerLabel];
        
        _windDirectLabel = [UILabel labelWithTextColor:[UIColor whiteColor]
                                      backgroundColor:[UIColor clearColor]
                                             fontSize:17
                                                lines:1
                                        textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_windDirectLabel];
        
        _L_H_tempLabel = [UILabel labelWithTextColor:[UIColor whiteColor]
                                     backgroundColor:[UIColor clearColor]
                                            fontSize:17
                                               lines:1
                                       textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_L_H_tempLabel];
        
        CGFloat windLabelWidth = (SCREEN_WIDTH - 50 - 20 - 5 * 2 - 25 * 2 - 60) / 2;
        
        [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.contentView);
            make.height.equalTo(@(25));
        }];
        
        [_weatherTypeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        
        [_weatherTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.weatherTypeIcon.mas_right).offset(20);
            make.top.equalTo(self.dateLabel.mas_bottom).offset(5);
            make.right.equalTo(self.dateLabel.mas_right);
        }];
        
        [_windPowerIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(25, 25));
            make.left.equalTo(self.weatherTypeLabel.mas_left);
            make.top.equalTo(self.weatherTypeLabel.mas_bottom).offset(5);
        }];
        
        [_windPowerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.windPowerIcon.mas_centerY);
            make.left.equalTo(self.windPowerIcon.mas_right);
            make.size.mas_equalTo(CGSizeMake(windLabelWidth, 25));
        }];
        
        [_windDirectIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.windPowerIcon);
            make.centerY.equalTo(self.windPowerIcon.mas_centerY);
            make.left.equalTo(self.windPowerLabel.mas_right);
        }];
        
        [_windDirectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.windPowerIcon.mas_centerY);
            make.size.mas_equalTo(self.windPowerLabel);
            make.left.equalTo(self.windDirectIcon.mas_right);
        }];
        
        [_L_H_tempIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.windPowerIcon.mas_centerX);
            make.top.equalTo(self.windPowerIcon.mas_bottom).offset(5);
            make.size.equalTo(self.windPowerIcon);
        }];
        
        [_L_H_tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.L_H_tempIcon.mas_top);
            make.centerY.equalTo(self.L_H_tempIcon.mas_centerY);
            make.right.equalTo(self.contentView.mas_right);
            make.left.equalTo(self.L_H_tempIcon.mas_right).offset(5);
        }];
        
    }
    return self;
}

- (void)setModel:(CKWeatherModel *)model {
    
    _weatherTypeIcon.image = [UIImage returnImageWithWeatherType:model.type];
    _weatherTypeLabel.text = model.type;
    _dateLabel.text = [NSString stringWithFormat:@"%@ %@",model.date,model.week];
    _windDirectLabel.text = model.fengxiang;
    _windPowerLabel.text = model.fengli;
    _L_H_tempLabel.text = [NSString stringWithFormat:@"Min:%@ ~ Max:%@",model.lowtemp,model.hightemp];
    
}


@end

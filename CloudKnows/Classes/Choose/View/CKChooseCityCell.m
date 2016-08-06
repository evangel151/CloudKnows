//
//  CKChooseCityCell.m
//  CloudKnows
//
//  Created by  a on 16/8/6.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "CKChooseCityCell.h"
#import "CKCityModel.h"

#import <Masonry.h>

@interface CKChooseCityCell ()


@property (nonatomic, strong) UIImageView *icon;
@end

@implementation CKChooseCityCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _icon = [[UIImageView alloc] init];
        [self.contentView addSubview:_icon];
        
        _cityNameLabel = [UILabel labelWithTextColor:[UIColor blueColor] backgroundColor:[UIColor clearColor] fontSize:17 lines:1 textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_cityNameLabel];
        
        
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.left.equalTo(self.contentView.mas_left).offset(30);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        
        [_cityNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.icon.mas_right).offset(10);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.top.bottom.right.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setCityModel:(CKCityModel *)cityModel {
    _cityModel = cityModel;
    
    if (self.type == CKChooseCityCellTypeHotCity) {
        
        self.icon.image = [UIImage imageNamed:@"button_info"];
        
    } else if (self.type == CKChooseCityCellTypeSearch){
        
        self.icon.image = [UIImage imageNamed:@"button_search"];
    }
    NSMutableString *str = [NSMutableString string];
    if (cityModel.province_cn && cityModel.province_cn.length > 0) {
        [str appendString:cityModel.province_cn];
    }
    if (cityModel.district_cn && cityModel.district_cn.length > 0) {
        [str appendFormat:@" %@",cityModel.district_cn];
    }
    if (cityModel.name_cn && cityModel.name_cn.length > 0 ) {
        [str appendFormat:@" %@",cityModel.name_cn];
    }
    self.cityNameLabel.text = str;

}

@end

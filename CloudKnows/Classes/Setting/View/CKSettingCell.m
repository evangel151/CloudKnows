//
//  CKSettingCell.m
//  CloudKnows
//
//  Created by  a on 16/8/4.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "CKSettingCell.h"
#import "CKCityModel.h"
#import <Masonry.h>

@interface CKSettingCell ()



@property (nonatomic, strong) UILabel *cityLabel;
@property (nonatomic, strong) UIButton *deleteButton;

@property (nonatomic, strong) CABasicAnimation *animation1;
@property (nonatomic, strong) CABasicAnimation *animation2;
@property (nonatomic, strong) CABasicAnimation *animation3;

@end

@implementation CKSettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        _cityLabel = [UILabel labelWithTextColor:[UIColor whiteColor]
                                 backgroundColor:[UIColor clearColor]
                                        fontSize:27
                                           lines:1
                                   textAlignment:NSTextAlignmentLeft];
        _cityLabel.font = [UIFont fontWithName:@"chalkboard SE" size:27];
        [self.contentView addSubview:_cityLabel];
        
        _deleteButton = [[UIButton alloc] init];
        [_deleteButton setImage:[UIImage imageNamed:@"deleteButton"] forState:UIControlStateNormal];
        [_deleteButton addTarget:self
                          action:@selector(deleteButtonDidClicked)
                forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_deleteButton];
        
        [_cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(40));
            make.left.equalTo(self.contentView.mas_left).offset(50);
            make.right.equalTo(self.deleteButton.mas_left);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        
        [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.right.equalTo(self.contentView.mas_right).offset(-50);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
    }
    return self;
}

- (void)deleteButtonDidClicked {
    if (self.block) {
        [_deleteButton.layer addAnimation:self.animation1 forKey:nil];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (anim == _animation1) {
        [_deleteButton.layer addAnimation:self.animation2 forKey:nil];
    } else if (anim == _animation2) {
        [_deleteButton.layer addAnimation:self.animation3 forKey:nil];
    } else {
         NSLog(@"动画执行完毕——————");
        [_deleteButton.layer removeAllAnimations];
        self.block(_city.area_id);
    }
}

- (void)setCity:(CKCityModel *)city {
    _city = city;
    
    NSMutableString *str = [NSMutableString string];
    if (_city.province_cn && _city.province_cn.length > 0) {
        [str appendString:_city.province_cn];
    }
    if (_city.district_cn && _city.district_cn.length > 0) {
        [str appendFormat:@" %@",_city.district_cn];
    }
    
    if (_city.name_cn && _city.name_cn.length > 0 ) {
        [str appendFormat:@" %@",_city.name_cn];
    }
    _cityLabel.text = str;
}

#pragma mark getter
// 动画getter
- (CABasicAnimation *)animation1 {
    if (!_animation1) {
        _animation1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        [_animation1 setDelegate:self];
        [_animation1 setFromValue:@0];
        [_animation1 setToValue:@ (2 * M_PI)];
        [_animation1 setDuration:1.0];
        [_animation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    }
    return _animation1;
}

- (CABasicAnimation *)animation2 {
    if (!_animation2) {
        _animation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        [_animation2 setDelegate:self];
        [_animation2 setFromValue:@0];
        [_animation2 setToValue:@ (2 * M_PI)];
        [_animation2 setDuration:1.0];
        [_animation2 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    }
    return _animation2;
}

- (CABasicAnimation *)animation3 {
    if (!_animation3) {
        _animation3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        [_animation3 setDelegate:self];
        [_animation3 setFromValue:@0];
        [_animation3 setToValue:@ (2 * M_PI)];
        [_animation3 setDuration:1.0];
        [_animation3 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    }
    return _animation3;
}


@end

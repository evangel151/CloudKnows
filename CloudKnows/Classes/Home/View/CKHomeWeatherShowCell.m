//
//  CKHomeWeatherShowCell.m
//  CloudKnows
//
//  Created by  a on 16/8/4.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "CKHomeWeatherShowCell.h"

#import "CKCityModel.h"

#import <Masonry.h>

@interface CKHomeWeatherShowCell ()

@property (nonatomic, strong) UIImageView *weatherIcon;


@end

@implementation CKHomeWeatherShowCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}



@end

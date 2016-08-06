//
//  CKChooseCityCell.h
//  CloudKnows
//
//  Created by  a on 16/8/6.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

typedef enum {
    CKChooseCityCellTypeHotCity,
    CKChooseCityCellTypeSearch
} CKChooseCityCellType;

#import <UIKit/UIKit.h>
@class CKCityModel;

@interface CKChooseCityCell : UITableViewCell

@property (nonatomic, strong) UILabel *cityNameLabel;

@property (nonatomic, strong) CKCityModel *cityModel;
@property (nonatomic, assign) CKChooseCityCellType type;

@end

//
//  CKSettingCell.h
//  CloudKnows
//
//  Created by  a on 16/8/4.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

typedef void (^DeleteButtonDidClicked)(NSString *);
#import <UIKit/UIKit.h>
@class CKCityModel;

@interface CKSettingCell : UITableViewCell

@property (nonatomic, strong) CKCityModel *city;
@property (nonatomic, copy) DeleteButtonDidClicked block;

@end

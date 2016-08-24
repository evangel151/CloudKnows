//
//  NullDataView.m
//  CloudKnows
//
//  Created by  a on 16/8/4.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "NullDataView.h"
#import <Masonry.h>
#import "CKChooseCityController.h"
#import "CKHomeWeatherController.h"

@interface NullDataView ()

@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIButton *pushButton;
@property (nonatomic, strong) UIImageView *bgImageView;

@end

@implementation NullDataView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.image = [UIImage imageNamed:@"nullData"];
        [self addSubview:_bgImageView];
        
        _descLabel = [UILabel labelWithTextColor:Color_Theme_Normal
                                 backgroundColor:[UIColor clearColor]
                                        fontSize:17
                                           lines:0
                                   textAlignment:NSTextAlignmentCenter];
        _descLabel.text = @"你还没有添加城市哦,\n 快去添加吧";
        [self addSubview:_descLabel];
        
        _pushButton = [UIButton buttonWithBackgroundColor:Color_Theme_Alpha
                                                    title:@"前往添加"
                                                 fontSize:17
                                               titleColor:[UIColor whiteColor]
                                                   target:self
                                                   action:@selector(pushToChooseCity:)
                                            clipsToBounds:YES];
        [self addSubview:_pushButton];
        
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(200, 200));
            make.centerY.equalTo(self.mas_centerY).offset(-100);
        }];
        
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.top.equalTo(self.bgImageView.mas_bottom).offset(20);
            make.height.equalTo(@(50));
        }];
        
        [_pushButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 50));
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.descLabel.mas_bottom).offset(20);
        }];

    }
    return self;
}

- (void)pushToChooseCity:(UIButton *)button {

        FindClassExample(superVc, CKHomeWeatherController);
        CKChooseCityController *choose = [[CKChooseCityController alloc] init];
        [superVc.navigationController pushViewController:choose animated:YES];    
}


@end

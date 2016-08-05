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
        
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.image = [UIImage imageNamed:@"Detail"];
        [self addSubview:_bgImageView];
        
        _descLabel = [UILabel labelWithTextColor:[UIColor purpleColor]
                                 backgroundColor:[UIColor clearColor]
                                        fontSize:17
                                           lines:0
                                   textAlignment:NSTextAlignmentRight];
        _descLabel.text = @"你还没有添加城市哦,\n 快去添加你需要专注的城市吧";
        [self addSubview:_descLabel];
        
        _pushButton = [UIButton buttonWithBackgroundColor:[UIColor clearColor]
                                                    title:@"点击添加"
                                                 fontSize:17
                                               titleColor:[UIColor purpleColor]
                                                   target:self
                                                   action:@selector(pushToChooseCity:)
                                            clipsToBounds:YES];
        [self addSubview:_pushButton];
        
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
        }];
        
        [_pushButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
        }];

    }
    return self;
}

- (void)pushToChooseCity:(UIButton *)button {
    if ([button respondsToSelector:@selector(pushToChooseCity:)]) {
        FindClassExample(superVc, CKHomeWeatherController);
        CKChooseCityController *choose = [[CKChooseCityController alloc] init];
        [superVc.navigationController pushViewController:choose animated:YES];
    }
    
}


@end

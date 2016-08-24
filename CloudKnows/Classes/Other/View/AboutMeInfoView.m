//
//  AboutMeInfoView.m
//  CloudKnows
//
//  Created by  a on 16/8/4.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "AboutMeInfoView.h"
#import <Masonry.h>

@interface AboutMeInfoView ()
/** 姓名 */
@property (nonatomic, strong) UILabel *nameLabel;
/** 个人信息 */
@property (nonatomic, strong) UILabel *infoLabel;
@end

@implementation AboutMeInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _nameLabel = [UILabel labelWithTextColor:[UIColor whiteColor]
                                 backgroundColor:[UIColor clearColor]
                                        fontSize:21
                                           lines:1
                                   textAlignment:NSTextAlignmentCenter];
        _nameLabel.text = @"by liji_ecat";
        _nameLabel.font = [UIFont fontWithName:@"chalkboard SE" size:30];
        [self addSubview:_nameLabel];
        
        _infoLabel = [UILabel labelWithTextColor:[UIColor whiteColor]
                                 backgroundColor:[UIColor clearColor]
                                        fontSize:17
                                           lines:0
                                   textAlignment:NSTextAlignmentCenter];
        _infoLabel.text = @"To be a coder！，感谢ManoBoo的开源分享。";
        _infoLabel.font = [UIFont fontWithName:@"chalkboard SE" size:19];
        [self addSubview:_infoLabel];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.equalTo(@(70));
        }];
        
        [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.nameLabel.mas_bottom);
        }];
        
    }
    return self;
}



@end

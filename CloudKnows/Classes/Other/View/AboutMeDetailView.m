//
//  AboutMeDetailView.m
//  CloudKnows
//
//  Created by  a on 16/8/3.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "AboutMeDetailView.h"
#import <Masonry.h>

@interface AboutMeDetailView ()

@property (nonatomic, strong) UIView *JianShuView;
@property (nonatomic, strong) UILabel *JianShuLabel;
@property (nonatomic, strong) UIImageView *JianShuIcon;
@property (nonatomic, strong) UIView *GitHubView;
@property (nonatomic, strong) UILabel *GitHubLabel;
@property (nonatomic, strong) UIImageView *GitHubIcon;

@property (nonatomic, strong) UIButton *backButton;

@end

@implementation AboutMeDetailView

#pragma mark - 构造方法
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _JianShuView = [[UIView alloc] init];
        [self addSubview:_JianShuView];
        UITapGestureRecognizer *tapJianshu = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(jsDidClick)];
        [_JianShuView addGestureRecognizer:tapJianshu];
        
        _JianShuIcon = [[UIImageView alloc] init];
        _JianShuIcon.image = [UIImage imageNamed:@"jianshu"];
        [_JianShuView addSubview:_JianShuIcon];
        
        _JianShuLabel = [UILabel labelWithTextColor:[UIColor whiteColor]
                                    backgroundColor:[UIColor clearColor]
                                           fontSize:21
                                              lines:1
                                      textAlignment:NSTextAlignmentLeft];
        _JianShuLabel.text = @"我的简书主页";
        [_JianShuView addSubview:_JianShuLabel];
        
        _GitHubView = [[UIView alloc] init];
        [self addSubview:_GitHubView];
        UITapGestureRecognizer *tapGit = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(gitDidClick)];
        [_GitHubView addGestureRecognizer:tapGit];
        
        _GitHubIcon = [[UIImageView alloc] init];
        _GitHubIcon.image = [UIImage imageNamed:@"github"];
        [_GitHubView addSubview:_GitHubIcon];
        
        _GitHubLabel = [UILabel labelWithTextColor:[UIColor whiteColor]
                                   backgroundColor:[UIColor clearColor]
                                          fontSize:21
                                             lines:1
                                     textAlignment:NSTextAlignmentLeft];
        _GitHubLabel.text = @"我的GitHub";
        [_GitHubView addSubview:_GitHubLabel];
        
        _backButton = [[UIButton alloc] init];
        _backButton.titleLabel.font = [UIFont systemFontOfSize:20];
        [_backButton setBackgroundColor:[UIColor purpleColor]];
        _backButton.layer.cornerRadius = 5;
        [_backButton setTitle:@"返回首页" forState:UIControlStateNormal];
        [_backButton setTintColor:[UIColor whiteColor]];
        [_backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backButton];
        
        [_JianShuIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self.JianShuView);
            make.width.equalTo(@(44));
        }];
        
        [_JianShuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self.JianShuView);
            make.left.equalTo(self.JianShuIcon.mas_right);
        }];
        
        [_JianShuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
        }];
        
        [_GitHubIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self.GitHubView);
            make.width.equalTo(@(44));
        }];
        
        [_GitHubLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self.GitHubView);
            make.left.equalTo(self.GitHubIcon.mas_right);
        }];
        
        [_GitHubView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
        }];
        
        [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.width.equalTo(@(100));
        }];
        
        // 感觉这样写效果还不错
        NSArray *subViewsArray = @[_JianShuView, _GitHubView, _backButton];
        [subViewsArray mas_distributeViewsAlongAxis:MASAxisTypeVertical
                                withFixedItemLength:44
                                        leadSpacing:20
                                        tailSpacing:20];
        
    }
    return self;
}


#pragma mark - 点击事件
- (void)back {
    if (self.block) self.block(DetailViewDidClicked_Backward);
}

- (void)jsDidClick {
    if (self.block) self.block(DetailViewDidClicked_JianShu);
}

- (void)gitDidClick {
    if (self.block) self.block(DetailViewDidClicked_GitHub);
}

@end

//
//  AboutMeController.m
//  CloudKnows
//
//  Created by  a on 16/8/3.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "AboutMeController.h"

#import "AboutMeDetailView.h"
#import "AboutMeInfoView.h"

#import <Masonry.h>

@interface AboutMeController ()

@property (nonatomic, strong) UIImageView       *wallerImageView;
@property (nonatomic, strong) AboutMeDetailView *detailView;
@property (nonatomic, strong) AboutMeInfoView   *infoView;

@end

@implementation AboutMeController
#pragma mark - 构成
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor lightGrayColor];
    [self setupWaller];
    [self setupInfoView];
    [self setupDetailView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)setupWaller {
    self.wallerImageView.image = [UIImage imageNamed:@"aboutMe_new"];
}

- (void)setupInfoView {
    _infoView = [[AboutMeInfoView alloc] init];
    [self.view addSubview:_infoView];
    
    [_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH * 0.6, SCREEN_WIDTH * 0.5));
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(100);
    }];
}

- (void)setupDetailView {

    WeakSelf;
    weakSelf.detailView.block = ^(NSInteger clickedAction) {
        switch (clickedAction) {
            case DetailViewDidClicked_Backward:{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
                break;
            case DetailViewDidClicked_JianShu:{
                [weakSelf pushWebViewWithUrl:@"http://www.jianshu.com/users/0195a84fa417/latest_articles"];
            }
                break;
            case DetailViewDidClicked_GitHub:{
                [weakSelf pushWebViewWithUrl:@"https://github.com/evangel151"];
            }
                break;
        }
    };
}

#pragma mark - getter 

- (UIImageView *)wallerImageView {
    if (!_wallerImageView) {
        _wallerImageView = [[UIImageView alloc] init];
        _wallerImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self.view insertSubview:_wallerImageView atIndex:0];
    }
    return _wallerImageView;
}

- (AboutMeDetailView *)detailView {
    if (!_detailView) {
        _detailView = [[AboutMeDetailView alloc] init];
        [self.view addSubview:_detailView];
        [_detailView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH * 0.6, SCREEN_WIDTH * 0.55));
            make.centerX.equalTo(self.view.mas_centerX);
            make.bottom.equalTo(self.view.mas_bottom).offset(-100);
        }];
    }
    return _detailView;
}


@end

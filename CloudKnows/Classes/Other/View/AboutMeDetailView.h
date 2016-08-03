//
//  AboutMeDetailView.h
//  CloudKnows
//
//  Created by  a on 16/8/3.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

typedef NS_ENUM(NSInteger, viewDidClickedAction) {
  
    DetailViewDidClicked_JianShu,
    DetailViewDidClicked_GitHub,
    DetailViewDidClicked_Backward
};

#import <UIKit/UIKit.h>

typedef void (^DetailViewDidClickedBlock)();

@interface AboutMeDetailView : UIView

@property (nonatomic, copy) DetailViewDidClickedBlock block;

@end

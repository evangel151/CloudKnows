//
//  UILabel+Extension.h
//  CloudKnows
//
//  Created by  a on 16/8/4.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)
+ (UILabel *)labelWithTextColor:(UIColor *)textColor
                backgroundColor:(UIColor *)backgroundColor
                       fontSize:(CGFloat)fontSize
                          lines:(NSUInteger)lines
                  textAlignment:(NSTextAlignment)textAlignment;


/**
 *  显示信息的指示器
 *
 *  @param stats 信息详情
 *  @param view  
 */
+ (void)showStats:(NSString *)stats atView:(UIView *)view;

@end

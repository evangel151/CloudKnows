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
@end

//
//  UILabel+Extension.m
//  CloudKnows
//
//  Created by  a on 16/8/4.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)
+ (UILabel *)labelWithTextColor:(UIColor *)textColor
                backgroundColor:(UIColor *)backgroundColor
                       fontSize:(CGFloat)fontSize
                          lines:(NSUInteger)lines
                  textAlignment:(NSTextAlignment)textAlignment {
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = textColor;
    label.backgroundColor = backgroundColor;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.numberOfLines = lines;
    label.textAlignment = textAlignment;
    return label;
}
@end

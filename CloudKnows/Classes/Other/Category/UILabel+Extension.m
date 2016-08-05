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


+ (void)showStats:(NSString *)stats atView:(UIView *)view {
    
    UILabel *message = [[UILabel alloc] init];
    message.layer.cornerRadius = 10;
    message.clipsToBounds = YES;
    message.backgroundColor = LJregular(0, 0, 0, 0.8);
    message.numberOfLines = 0;
    message.font = [UIFont systemFontOfSize:15];
    message.textColor = [UIColor whiteColor];
    message.textAlignment = NSTextAlignmentCenter;
    message.alpha = 0;
    
    message.text = stats;
    CGSize size = [stats boundingRectWithSize:CGSizeMake(MAXFLOAT, 50)
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]}
                                      context:nil].size;
    message.frame = CGRectMake(0, 0, size.width + 20, size.height + 10);
    message.center = view.center;
    [view addSubview:message];
    
    [UIView animateWithDuration:1.5 animations:^{
        message.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2 animations:^{
            message.alpha = 0;
        } completion:^(BOOL finished) {
            [message removeFromSuperview];
            
        }];
    }];
}

@end

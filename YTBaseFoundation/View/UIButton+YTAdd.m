//
//  UIButton+YTAdd.m
//  YTBaseFoundation
//
//  Created by vaint on 16/8/21.
//  Copyright © 2016年 vaint. All rights reserved.
//

#import "UIButton+YTAdd.h"

@implementation UIButton (YTAdd)

+(UIButton*)buttonWithFrame:(CGRect)frame
                   frontImg:(UIImage*)image
                     target:(id)target
                     action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    btn.frame = frame;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+(UIButton*)buttonWithFrame:(CGRect)frame
                      title:(NSString*)title
                       font:(UIFont*)font
                      color:(UIColor*)color
{
    return [self buttonWithFrame:frame title:title font:font color:color normalImg:nil pressedImg:nil];
}

+(UIButton*)buttonWithFrame:(CGRect)frame
                      title:(NSString*)title
                       font:(UIFont*)font
                      color:(UIColor*)color
                  normalImg:(UIImage*)normalImg
                 pressedImg:(UIImage*)pressedImg
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectIntegral(frame);
    
    [btn setTitle:title forState:UIControlStateNormal];
    
    if(font)
    {
        btn.titleLabel.font = font;
    }
    if(color)
    {
        [btn setTitleColor:color forState:UIControlStateNormal];
    }
    if(normalImg)
    {
        [btn setBackgroundImage:normalImg forState:UIControlStateNormal];
    }
    if(pressedImg)
    {
        [btn setBackgroundImage:pressedImg forState:UIControlStateHighlighted];
    }
    
    return btn;
}

@end

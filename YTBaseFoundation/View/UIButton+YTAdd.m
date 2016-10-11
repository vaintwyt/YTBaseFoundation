//
//  UIButton+YTAdd.m
//  YTBaseFoundation
//
//  Created by vaint on 16/8/21.
//  Copyright © 2016年 vaint. All rights reserved.
//

#import "UIButton+YTAdd.h"
#import "UIView+YTAdd.h"

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

- (void)layoutButtonWithStyle:(ButtonImgStyle)style
                imgTitleSpace:(CGFloat)space
{
    CGFloat imgW = self.imageView.width;
    CGFloat imgH = self.imageView.height;
    
    CGFloat labelW = self.titleLabel.intrinsicContentSize.width;// iOS8
    CGFloat labelH = self.titleLabel.intrinsicContentSize.height;
    
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    switch (style) {
        case ButtonImgStyleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelH-space/2.0, 0, 0, -labelW);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imgW, -imgH-space/2.0, 0);
        }
            break;
        case ButtonImgStyleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case ButtonImgStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelH-space/2.0, -labelW);
            labelEdgeInsets = UIEdgeInsetsMake(-imgH-space/2.0, -imgW, 0, 0);
        }
            break;
        case ButtonImgStyleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelW+space/2.0, 0, -labelW-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imgW-space/2.0, 0, imgW+space/2.0);
        }
            break;
        default:
            break;
    }
    
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}

@end

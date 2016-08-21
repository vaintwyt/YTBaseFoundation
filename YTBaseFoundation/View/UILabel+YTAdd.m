//
//  UILabel+YTAdd.m
//  YTBaseFoundation
//
//  Created by vaint on 16/8/21.
//  Copyright © 2016年 vaint. All rights reserved.
//

#import "UILabel+YTAdd.h"
#import "NSString+YTAdd.h"

@implementation UILabel (YTAdd)

+(UILabel*)labelWithText:(NSString*)text
                    font:(UIFont*)font
                   color:(UIColor*)color
{
    return [self labelWithFrame:CGRectZero text:text font:font color:color adjust:NO];
}

+(UILabel*)labelWithSize:(CGSize)size
                    text:(NSString*)text
                    font:(UIFont*)font
                   color:(UIColor*)color
{
    return [self labelWithFrame:CGRectMake(0, 0, size.width, size.height) text:text font:font color:color adjust:YES];
}

+(UILabel*)labelWithFrame:(CGRect)frame
                     text:(NSString*)text
                     font:(UIFont*)font
                    color:(UIColor*)color
{
    return [self labelWithFrame:frame text:text font:font color:color adjust:NO];
}

+(UILabel*)labelWithFrame:(CGRect)frame
                     text:(NSString*)text
                     font:(UIFont*)font
                    color:(UIColor*)color
                   adjust:(BOOL)adjust
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    if(font)
    {
        label.font = font;
    }
    if(color)
    {
        label.textColor = color;
    }
    label.adjustsFontSizeToFitWidth = adjust;
    
    label.numberOfLines = 0;
    
    return label;
}

+(UILabel*)labelWithPoint:(CGPoint)point
                     text:(NSString*)text
                     font:(UIFont*)font
                    color:(UIColor*)color
{
    CGSize size = [text sizeWithFont:font];
    
    return [self labelWithFrame:CGRectMake(point.x, point.y, size.width, font.pointSize) text:text font:font color:color adjust:NO];
}

+(UILabel*)labelMultiLineWithFrame:(CGRect)frame
                              text:(NSString*)text
                              font:(UIFont*)font
                             color:(UIColor*)color
{
    UILabel *label = [self labelWithFrame:frame text:text font:font color:color adjust:NO];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    
    frame.size.height = MAXFLOAT;
    CGSize size = [text sizeWithFont:font constrainedToSize:frame.size];
    frame.size.height = size.height;
    label.frame = frame;
    return label;
}

@end

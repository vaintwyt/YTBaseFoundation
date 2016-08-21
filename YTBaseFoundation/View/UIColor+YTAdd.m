//
//  UIColor+YTAdd.m
//  YTBaseFoundation
//
//  Created by vaint on 16/8/21.
//  Copyright © 2016年 vaint. All rights reserved.
//

#import "UIColor+YTAdd.h"

@implementation UIColor (YTAdd)

+(UIColor*)colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b A:(CGFloat)a
{
    return [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)];
}

+(UIColor*)colorWithHex:(NSString*)hex
{
    // 转换成标准16进制数
    NSMutableString * colorStr = [[NSMutableString alloc] initWithString:hex];
    [colorStr replaceCharactersInRange:[colorStr rangeOfString:@"#" ] withString:@"0x"];
    // 十六进制字符串转成整形。
    long colorLong = strtoul([colorStr cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);
    // 通过位与方法获取三色值
    int R = (colorLong & 0xFF0000 )>>16;
    int G = (colorLong & 0x00FF00 )>>8;
    int B =  colorLong & 0x0000FF;
    //string转color
    return [UIColor colorWithR:R G:G B:B A:1];
}

@end

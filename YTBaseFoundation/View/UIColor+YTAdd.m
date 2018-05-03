//
//  UIColor+YTAdd.m
//  YTBaseFoundation
//
//  Created by YT on 16/8/21.
//  Copyright © 2016年 YT. All rights reserved.
//

#import "UIColor+YTAdd.h"

@implementation UIColor (YTAdd)

+(UIColor*)colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b A:(CGFloat)a
{
    return [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)];
}

+(UIColor*)colorWithHex:(uint32_t)hex
{
//    if(hex.length != 6) return nil;
    
    // 转换成标准16进制数
//    hex = [NSString stringWithFormat:@"0x%@",hex];
//    NSMutableString * colorStr = [[NSMutableString alloc] initWithString:hex];
//    [colorStr replaceCharactersInRange:[colorStr rangeOfString:@"#" ] withString:@"0x"];
    
    // 十六进制字符串转成整形。
//    long colorLong = strtoul([hex cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);
    
    // 通过位与方法获取三色值
    int R = (hex & 0xFF0000 )>>16;
    int G = (hex & 0x00FF00 )>>8;
    int B =  hex & 0x0000FF;
    
    //string转color
    return [UIColor colorWithR:R G:G B:B A:1];
}

@end

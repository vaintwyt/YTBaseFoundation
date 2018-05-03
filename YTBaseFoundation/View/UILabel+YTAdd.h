//
//  UILabel+YTAdd.h
//  YTBaseFoundation
//
//  Created by YT on 16/8/21.
//  Copyright © 2016年 YT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (YTAdd)

+(UILabel*)labelWithText:(NSString*)text
                    font:(UIFont*)font
                   color:(UIColor*)color;

+(UILabel*)labelWithSize:(CGSize)size
                    text:(NSString*)text
                    font:(UIFont*)font
                   color:(UIColor*)color;

// adjust:NO
+(UILabel*)labelWithFrame:(CGRect)frame
                     text:(NSString*)text
                     font:(UIFont*)font
                    color:(UIColor*)color;

+(UILabel*)labelWithFrame:(CGRect)frame
                     text:(NSString*)text
                     font:(UIFont*)font
                    color:(UIColor*)color
                   adjust:(BOOL)adjust;

// 根据text和font，控制Label的大小
+(UILabel*)labelWithPoint:(CGPoint)point
                     text:(NSString*)text
                     font:(UIFont*)font
                    color:(UIColor*)color;

+(UILabel*)labelMultiLineWithFrame:(CGRect)frame
                              text:(NSString*)text
                              font:(UIFont*)font
                             color:(UIColor*)color;

@end

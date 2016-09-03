//
//  UIButton+YTAdd.h
//  YTBaseFoundation
//
//  Created by vaint on 16/8/21.
//  Copyright © 2016年 vaint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (YTAdd)

+(UIButton*)buttonWithFrame:(CGRect)frame
                   frontImg:(UIImage*)image
                     target:(id)target
                     action:(SEL)action;

+(UIButton*)buttonWithFrame:(CGRect)frame
                      title:(NSString*)title
                       font:(UIFont*)font
                      color:(UIColor*)color;


+(UIButton*)buttonWithFrame:(CGRect)frame
                      title:(NSString*)title
                       font:(UIFont*)font
                      color:(UIColor*)color
                  normalImg:(UIImage*)normalImg
                 pressedImg:(UIImage*)pressedImg;

@end

//
//  UIButton+YTAdd.h
//  YTBaseFoundation
//
//  Created by YT on 16/8/21.
//  Copyright © 2016年 YT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ButtonImgStyle) {
    ButtonImgStyleTop, // image在上，label在下
    ButtonImgStyleLeft, // image在左，label在右
    ButtonImgStyleBottom, // image在下，label在上
    ButtonImgStyleRight // image在右，label在左
};

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

- (void)layoutButtonWithStyle:(ButtonImgStyle)style
                imgTitleSpace:(CGFloat)space;

@end

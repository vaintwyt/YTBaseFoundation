//
//  UIColor+YTAdd.h
//  YTBaseFoundation
//
//  Created by vaint on 16/8/21.
//  Copyright © 2016年 vaint. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 0~255 */
#define YTColor(r,g,b)      [UIColor colorWithR:r G:g B:b A:1]
#define YTColorA(r,g,b,a)   [UIColor colorWithR:r G:g B:b A:a]
#define YTShortColor(c)     [UIColor colorWithR:c G:c B:c A:1]
#define YTShortColorA(c,a)  [UIColor colorWithR:c G:c B:c A:a]

/** hex:ABABAB */
#define YTHexColor(hex)     [UIColor colorWithHex:hex]


@interface UIColor (YTAdd)

+(UIColor*)colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b A:(CGFloat)a;

+(UIColor*)colorWithHex:(uint32_t)hex;

@end

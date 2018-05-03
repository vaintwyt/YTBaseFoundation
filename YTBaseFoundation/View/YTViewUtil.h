//
//  YTViewUtil.h
//  YTBaseFoundation
//
//  Created by YT on 16/8/21.
//  Copyright © 2016年 YT. All rights reserved.
//


#define YTScreenW                       [YTViewUtil screenWidth]
#define YTScreenH                       [YTViewUtil screenHeight]
#define YTStatusBarH                    [YTViewUtil statusBarHeight]
#define YTNavBarH                       [YTViewUtil navBarHeight]
#define YTBottomBarH                    49
#define YTViewH                         (YTScreenH-YTStatusBarH-YTNavBarH)

#define YTOnePx                         [YTViewUtil onePx]


@interface YTViewUtil : NSObject

+(CGFloat)screenWidth;
+(CGFloat)screenHeight;
+(CGFloat)statusBarHeight;
+(CGFloat)navBarHeight;

+(CGFloat)onePx;

@end




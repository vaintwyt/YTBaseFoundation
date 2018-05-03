//
//  YTViewUtil.m
//  YTBaseFoundation
//
//  Created by YT on 16/8/21.
//  Copyright © 2016年 YT. All rights reserved.
//

#import "YTViewUtil.h"

@implementation YTViewUtil

+(CGFloat)screenWidth
{
    static CGFloat s_scrWidth = 0;
    if (s_scrWidth == 0){
        UIScreen* screen = [UIScreen mainScreen];
        CGRect screenFrame = screen.bounds;
        s_scrWidth = MIN(screenFrame.size.width, screenFrame.size.height);
        
    }
    
    return s_scrWidth;
}

+(CGFloat)screenHeight
{
    static CGFloat s_scrHeight = 0;
    if (s_scrHeight == 0){
        UIScreen* screen = [UIScreen mainScreen];
        CGRect screenFrame = screen.bounds;
        s_scrHeight = MAX(screenFrame.size.height, screenFrame.size.width);
    }
    return s_scrHeight;
}

+(CGFloat)statusBarHeight
{
    static CGFloat s_statusBarH = 0;
    if(s_statusBarH == 0)
    {
        s_statusBarH = [[UIApplication sharedApplication] statusBarFrame].size.height;
    }
    return s_statusBarH;
}

+(CGFloat)navBarHeight;
{
    static CGFloat s_navBarH = 0;
    if(s_navBarH == 0)
    {
        UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
        if([vc isKindOfClass:[UINavigationController class]])
        {
            s_navBarH = ((UINavigationController*)vc).navigationBar.frame.size.height;
        }
        else
        {
            s_navBarH = vc.navigationController.navigationBar.frame.size.height;
        }
        
    }
    return s_navBarH;
}

+(CGFloat)onePx
{
    static CGFloat s_onePx = 0;
    if(s_onePx == 0)
    {
        s_onePx = (1.0/[UIScreen mainScreen].scale);
    }
    return s_onePx;
}

@end

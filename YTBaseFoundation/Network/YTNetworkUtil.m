//
//  YTNetworkUtil.m
//  YTBaseFoundation
//
//  Created by YT on 16/8/23.
//  Copyright © 2016年 YT. All rights reserved.
//

#import "YTNetworkUtil.h"

@implementation YTNetworkUtil

+(BOOL)checkUrl:(NSString*)url
{
    if(![url hasPrefix:@"http://"] && ![url hasPrefix:@"https://"])
        return NO;
    
    return YES;
}

@end

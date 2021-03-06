//
//  NSDictionary+YTAdd.m
//  YTBaseFoundation
//
//  Created by YT on 16/8/21.
//  Copyright © 2016年 YT. All rights reserved.
//

#import "NSDictionary+YTAdd.h"
#import "NSString+YTAdd.h"

@implementation NSDictionary (YTAdd)

-(NSString*)paramString
{
    NSMutableArray *pairs = [NSMutableArray array];
    
    for (NSString *key in [self allKeys]) {
        NSString * value = [self objectForKey:key];
        
        if (value == nil || [value isEqualToString:@""]) {
            continue;
        }
        
        NSString *pair = [NSString stringWithFormat: @"%@=%@",key, [value urlEncode]];
        [pairs addObject:pair];
    }
    
    return [pairs componentsJoinedByString:@"&"];//利用指定的分割符连接成字符串并返回
}

@end

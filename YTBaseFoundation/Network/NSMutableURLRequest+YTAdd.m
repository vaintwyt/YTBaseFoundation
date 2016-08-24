//
//  NSMutableURLRequest+YTAdd.m
//  YTBaseFoundation
//
//  Created by vaintwen on 16/8/23.
//  Copyright © 2016年 vaint. All rights reserved.
//

#import "NSMutableURLRequest+YTAdd.h"
#import "NSString+YTAdd.h"
#import "NSDictionary+YTAdd.h"
#import "YTNetworkUtil.h"

@implementation NSMutableURLRequest (YTAdd)

+(NSMutableURLRequest*)URLRequestWithPath:(NSString*)path
                                   method:(NSString*)method
                                   params:(NSDictionary*)params
                                httpHeads:(NSDictionary*)httpHeads
                                   cookie:(NSString*)cookie
{
    if(![YTNetworkUtil checkUrl:path])
        return nil;
    
    NSString *paramStr = [params paramString];
    
    NSMutableURLRequest *request = nil;
    if([method isEqualToString:@"GET"])
    {
        path = [path stringByAppendingFormat:@"%@?%@",path,paramStr];
        path = [path urlEncode];
    }
    else
    {
        request.HTTPBody = [paramStr dataUsingEncoding:NSUTF8StringEncoding];
    }
    request.URL = [NSURL URLWithString:path];
    request.HTTPMethod = method;
    
    NSArray *allHeaderKeys = [httpHeads allKeys];
    for (NSString *headerKey in allHeaderKeys)
    {
        NSString *headerValue = httpHeads[headerKey];
        if ([headerKey isKindOfClass:[NSString class]] && [headerValue isKindOfClass:[NSString class]])
        {
            [request setValue:headerValue forHTTPHeaderField:headerKey];
        }
    }
    
    if (cookie.length > 0)
    {
        [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    }
    
    return request;
}

@end

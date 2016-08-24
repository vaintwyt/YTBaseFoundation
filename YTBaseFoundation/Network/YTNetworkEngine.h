//
//  YTNetworkEngine.h
//  YTBaseFoundation
//
//  Created by vaint on 16/8/22.
//  Copyright © 2016年 vaint. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^YTNetworkSuccess)(NSURLSessionTask *task, id data);
typedef void (^YTNetworkFailure)(NSURLSessionTask *task, NSError *err);

@interface YTNetworkEngine : NSObject

+(NSURLSessionTask*)requestWithURLRequest:(NSURLRequest*)request
                                  success:(YTNetworkSuccess)success
                                  failure:(YTNetworkFailure)failure;

+(NSURLSessionTask*)downloadWithPath:(NSString*)path
                             success:(YTNetworkSuccess)success
                             failure:(YTNetworkFailure)failure;


+(NSURLSessionTask*)uploadWithRequest:(NSURLRequest*)request
                                 data:(NSData*)data
                              success:(YTNetworkSuccess)success
                              failure:(YTNetworkFailure)failure;


@end

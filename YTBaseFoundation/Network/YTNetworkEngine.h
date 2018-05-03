//
//  YTNetworkEngine.h
//  YTBaseFoundation
//
//  Created by YT on 16/8/22.
//  Copyright © 2016年 YT. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^YTNetworkSuccess)(NSURLSessionTask *task, id data);
typedef void (^YTNetworkFailure)(NSURLSessionTask *task, NSError *err);

@interface YTNetworkEngine : NSObject

/**
 *  发起网络请求
 *
 *  @param request 请求包
 *  @param success 成功回调
 *  @param failure 失败回调
 *
 *  @return 当次网络请求任务对象
 */
+(NSURLSessionTask*)requestWithURLRequest:(NSURLRequest*)request
                                  success:(YTNetworkSuccess)success
                                  failure:(YTNetworkFailure)failure;

/**
 *  发起下载请求
 *
 *  @param path    下载路径
 *  @param success 成功回调
 *  @param failure 失败回调
 *
 *  @return 当次下载任务对象
 */
+(NSURLSessionTask*)downloadWithPath:(NSString*)path
                             success:(YTNetworkSuccess)success
                             failure:(YTNetworkFailure)failure;


/**
 *  发起上传请求
 *
 *  @param request 上传请求
 *  @param data    上传数据
 *  @param success 成功回调
 *  @param failure 失败回调
 *
 *  @return 当次上传任务对象
 */
+(NSURLSessionTask*)uploadWithRequest:(NSURLRequest*)request
                                 data:(NSData*)data
                              success:(YTNetworkSuccess)success
                              failure:(YTNetworkFailure)failure;


@end

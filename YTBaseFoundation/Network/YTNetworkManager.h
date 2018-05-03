//
//  YTNetworkManager.h
//  YTBaseFoundation
//
//  Created by YT on 16/8/23.
//  Copyright © 2016年 YT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTNetworkDefine.h"


typedef void (^YTNetworkCallback)(id tag, NSDictionary *resData, NSDictionary *exData);


@interface YTNetworkManager : NSObject

YTSharedInstance;

/**
 *  请求路径的前缀
 */
@property(nonatomic, strong) NSString *prefixPath;

/**
 *  发起网络请求
 *
 *  @param tag      当次请求的标识，建议用接口名称
 *  @param path     请求路径。设置prefixPath后，path可以为相对路径
 *  @param method   请求方式
 *  @param params   请求参数
 *  @param exParams 本地透传的参数，不会提交后台
 *  @param callback 回调方法
 */
-(void)requestWithTag:(id)tag
                 path:(NSString*)path
               method:(NSString*)method
               params:(NSDictionary*)params
             exParams:(NSDictionary*)exParams
             callback:(YTNetworkCallback)callback;

-(void)cancelRequestWithTag:(id)tag;

-(void)cancelAllRequest;


@end

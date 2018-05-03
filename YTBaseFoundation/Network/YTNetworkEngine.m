//
//  YTNetworkEngine.m
//  YTBaseFoundation
//
//  Created by YT on 16/8/22.
//  Copyright © 2016年 YT. All rights reserved.
//

#import "YTNetworkEngine.h"
#import "NSString+YTAdd.h"
#import "NSDictionary+YTAdd.h"
#import "YTNetworkUtil.h"

@interface YTNetworkEngine ()

@end


@implementation YTNetworkEngine

+(NSURLSessionTask*)requestWithURLRequest:(NSURLRequest*)request
                                  success:(YTNetworkSuccess)success
                                  failure:(YTNetworkFailure)failure

{
    if(!request)
        return nil;
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    __block NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(!error && success)
        {
            success(task,data);
        }
        else if(error && failure)
        {
            failure(task,error);
        }
        
    }];
    
    [task resume];
    return task;
}

+(NSURLSessionTask*)downloadWithPath:(NSString*)path
                             success:(YTNetworkSuccess)success
                             failure:(YTNetworkFailure)failure

{
    if(![YTNetworkUtil checkUrl:path])
    {
        return nil;
    }
    
    NSURL *url = [NSURL URLWithString:path] ;
    NSURLSession *session = [NSURLSession sharedSession];
    
    __block NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        /*
         1、location是沙盒中tmp文件夹下的一个临时url,文件下载后会存到这个位置,由于tmp中的文件随时可能被删除,所以我们需要自己需要把下载的文件移动到其他地方:pathUrl.
         2、response.suggestedFilename是从相应中取出文件在服务器上存储路径的最后部分，例如根据本路径为，最后部分应该为：“image.png”
         */
        
        if(!error && success)
        {
            NSData *data = [NSData dataWithContentsOfURL:location];
            success(task,data);
        }
        else if(error && failure)
        {
            failure(task,error);
        }
        
    }];
    
    [task resume];
    return task;
}

+(NSURLSessionTask*)uploadWithRequest:(NSURLRequest*)request
                                 data:(NSData*)data
                              success:(YTNetworkSuccess)success
                              failure:(YTNetworkFailure)failure

{
    if(!request)
        return nil;
    
    NSURLSession *session = [NSURLSession sharedSession];
    __block NSURLSessionUploadTask *task = [session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error && success)
        {
            success(task,data);
        }
        else if(error && failure)
        {
            failure(task,error);
        }
    }];
    
    [task resume];
    return task;
}



@end

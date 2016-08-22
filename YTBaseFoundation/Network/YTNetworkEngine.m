//
//  YTNetworkEngine.m
//  YTBaseFoundation
//
//  Created by vaint on 16/8/22.
//  Copyright © 2016年 vaint. All rights reserved.
//

#import "YTNetworkEngine.h"
#import "NSString+YTAdd.h"
#import "NSDictionary+YTAdd.h"

@interface YTNetworkEngine () <NSURLSessionDownloadDelegate>

@end


@implementation YTNetworkEngine

YTDefine_SharedInstance(YTNetworkEngine);


+(NSMutableURLRequest*)URLRequestWithPath:(NSString*)path
                                   method:(NSString*)method
                                   params:(NSDictionary*)params
                                httpHeads:(NSDictionary*)httpHeads
                                   cookie:(NSString*)cookie
{
    if(![YTNetworkEngine p_checkUrlPath:path])
    {
        return nil;
    }
    
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
    if(![YTNetworkEngine p_checkUrlPath:path])
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



#pragma mark- NSURLSessionDownloadDelegate
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    
}

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    
}

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    
}


#pragma mark- private func
+(BOOL)p_checkUrlPath:(NSString*)path
{
    if([path hasPrefix:@"http://"] || [path hasPrefix:@"https://"])
        return YES;
    
    return NO;
}


@end

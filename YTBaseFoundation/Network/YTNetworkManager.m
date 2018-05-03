//
//  YTNetworkManager.m
//  YTBaseFoundation
//
//  Created by YT on 16/8/23.
//  Copyright © 2016年 YT. All rights reserved.
//

#import "YTNetworkManager.h"
#import "YTNetworkUtil.h"
#import "NSMutableURLRequest+YTAdd.h"
#import "YTNetworkEngine.h"


#define Key_ReqTag @"req_tag"
#define Key_ReqExParams @"req_ex_params"
#define Key_ReqCallback @"req_callback"


@interface YTNetworkManager ()

@property(nonatomic, strong) NSMutableDictionary<NSURLSessionTask*,NSDictionary*> *reqTaskCache;

@end

@implementation YTNetworkManager

YTDefine_SharedInstance(YTNetworkManager);

-(void)requestWithTag:(id)tag
                 path:(NSString*)path
               method:(NSString*)method
               params:(NSDictionary*)params
             exParams:(NSDictionary*)exParams
             callback:(YTNetworkCallback)callback
{
    NSString *fullPath = nil;
    if([YTNetworkUtil checkUrl:path])
    {
        fullPath = path;
    }
    else if(self.prefixPath)
    {
        if([self.prefixPath hasSuffix:@"\\"])
        {
            fullPath = [self.prefixPath stringByAppendingString:path];
        }else
        {
            fullPath = [self.prefixPath stringByAppendingFormat:@"\\%@",path];
        }
    }
    
    if(!fullPath)
        return;
    
        
    NSMutableURLRequest *request = [NSMutableURLRequest URLRequestWithPath:fullPath method:method params:params httpHeads:nil cookie:nil];
    request.timeoutInterval = 15;
    
    YTWeakSelf(wSelf);
    NSURLSessionTask *task = [YTNetworkEngine requestWithURLRequest:request
                            success:^(NSURLSessionTask *task, id data) {
                                
                                NSError *error;
                                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                                if(error)
                                {
                                    DebugLog(@"解析后台数据失败\n%@",error);
                                    dic = @{YTRetCode:YTRetCode_ResDataError,YTRetMsg:YTRetMsg_ResDataError};
                                }
                                
                                [wSelf p_responseWithTask:task resData:dic];
                                
                            }
                            failure:^(NSURLSessionTask *task, NSError *err) {
                                
                                NSString* retCode=nil;
                                NSString* retMsg = nil;
                                
                                if (err.code == NSURLErrorTimedOut) {
                                    retCode = YTRetCode_NetworkError;
                                    retMsg = YTRetMsg_ReqTimeout;
                                }
                                else if (err.code == NSURLErrorNetworkConnectionLost) {
                                    retCode = YTRetCode_NetworkError;
                                    retMsg = YTRetMsg_ReqLost;
                                }
                                else if (err.code == NSURLErrorCancelled) {
                                    retCode = YTRetCode_NetworkError;
                                    retMsg = YTRetMsg_ReqCancle;
                                }
                                else if (err.code == NSURLErrorCannotConnectToHost ) {
                                    retCode = YTRetCode_NoNetwork;
                                    retMsg = YTRetMsg_NoNetwork;
                                }
                                else
                                {
                                    retCode = YTRetCode_NoNetwork;
                                    retMsg = YTRetMsg_NoNetwork;
                                }
                                
                                NSDictionary *resData = @{YTRetCode:retCode,YTRetMsg:retMsg};
                                [wSelf p_responseWithTask:task resData:resData];
                                
                            }];
    
    if(task)
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[Key_ReqTag] = tag;
        dic[Key_ReqExParams] = exParams;
        dic[Key_ReqCallback] = callback;
        
        self.reqTaskCache[task] = dic;
    }

    
    
}


-(void)cancelRequestWithTag:(id)tag
{
    NSMutableArray *delTasks = [NSMutableArray array];
    for (NSURLSessionTask *task in self.reqTaskCache) {
        NSDictionary *dic = self.reqTaskCache[task];
        id aTag = dic[Key_ReqTag];
        if([aTag isEqual:tag])
        {
            [task cancel];
            [delTasks addObject:task];
        }
    }
    
    [self.reqTaskCache removeObjectsForKeys:delTasks];
}

-(void)cancelAllRequest
{
    for (NSURLSessionTask *task in self.reqTaskCache) {
        [task cancel];
    }
    
    [self.reqTaskCache removeAllObjects];
}



-(void)p_responseWithTask:(NSURLSessionTask*)task resData:(NSDictionary*)resData
{
    NSDictionary *dic = [self.reqTaskCache objectForKey:task];
    if(dic)
    {
        [self.reqTaskCache removeObjectForKey:task];
        
        YTNetworkCallback callback = dic[Key_ReqCallback];
        if(callback)
        {
            callback(dic[Key_ReqTag], resData, dic[Key_ReqExParams]);
        }
        
    }
    else
    {
        DebugLog(@"找不到请求包\n%@",resData);
    }
}



#pragma mark- Getter&Setter
-(NSMutableDictionary<NSURLSessionTask*,NSDictionary *> *)reqTaskCache
{
    if(!_reqTaskCache)
    {
        _reqTaskCache = [NSMutableDictionary dictionary];
    }
    return _reqTaskCache;
}

@end

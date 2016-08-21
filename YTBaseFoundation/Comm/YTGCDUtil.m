//
//  YTGCDUtil.m
//  YTBaseFoundation
//
//  Created by vaint on 16/8/21.
//  Copyright © 2016年 vaint. All rights reserved.
//

#import "YTGCDUtil.h"

@implementation YTGCDUtil

+(dispatch_queue_t)concurrentQueue
{
    static dispatch_queue_t s_concurrentQueue = nil;
    if(s_concurrentQueue == nil)
    {
        s_concurrentQueue = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    }
    return s_concurrentQueue;
}

+(dispatch_queue_t)sirealQueue
{
    static dispatch_queue_t s_sirealQueue = nil;
    if(s_sirealQueue == nil)
    {
        s_sirealQueue = dispatch_queue_create("sirealQueue", DISPATCH_QUEUE_SERIAL);
    }
    return s_sirealQueue;
}


+(void)asyncBlock:(void (^)(void))block
{
    [self asyncBlock:block sireal:NO];
}

+(void)asyncBlock:(void (^)(void))block sireal:(BOOL)isSireal
{
    if(!block) return;
    
    if(isSireal)
    {
        dispatch_async([self sirealQueue],block);
    }else
    {
        dispatch_async([self concurrentQueue],block);
        
    }
    
    
}

+(void)syncBlockInMain:(void (^)(void))block
{
    if(block == nil)
        return;
    
    if([NSThread isMainThread])// 本来就在主线程，直接执行
    {
        block();
    }else
    {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

+(void)asyncBlockInMain:(void (^)(void))block
{
    if(block == nil)
        return;
    
    dispatch_async(dispatch_get_main_queue(), block);
}

@end

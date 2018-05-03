//
//  YTTimeoutTimer.m
//  YTBaseFoundation
//
//  Created by YT on 2018/5/3.
//  Copyright © 2018年 YT. All rights reserved.
//

#import "YTTimeoutTimer.h"

@interface YTTimeoutTimer ()
{
    dispatch_source_t _timer;
}

@end

@implementation YTTimeoutTimer

+(instancetype)timerWithTimeout:(NSTimeInterval)timeout block:(void (^)(void))block
{
    YTTimeoutTimer *timer = [YTTimeoutTimer new];
    timer.timeout = timeout;
    timer.timeoutBlock = block;
    return timer;
}


-(void)startTimeout
{
    if(!self.timeoutBlock) return;
    
    if(_timer)
    {
        [self stopTimeout];
    }
    
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, nil);
    YTWeakSelf
    dispatch_source_set_event_handler(_timer, ^{
        dispatch_sync(dispatch_get_main_queue(), ^{
            YTStrongSelfNotNil
            if(sSelf.timeoutBlock)
                sSelf.timeoutBlock();
            sSelf.timeoutBlock = nil;
        });
        
    });
    dispatch_time_t tt = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.timeout * NSEC_PER_SEC));
    dispatch_source_set_timer(_timer, tt, DISPATCH_TIME_FOREVER, 0);
    dispatch_resume(_timer);
}


-(void)stopTimeout
{
    if (_timer)
    {
        dispatch_source_cancel(_timer);
        _timer = NULL;
    }
}

@end

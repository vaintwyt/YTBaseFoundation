//
//  YTTimer.m
//  YTBaseFoundation
//
//  Created by YT on 2018/5/3.
//  Copyright © 2018年 YT. All rights reserved.
//

#import "YTTimer.h"
#import "YTWeakProxy.h"


@interface YTTimer ()

@property (nonatomic, strong) NSTimer *realTimer;

@end

@implementation YTTimer

- (instancetype)init
{
    self = [super init];
    if (self) {
        [YTNotifyCenter addObserver:self selector:@selector(appDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [YTNotifyCenter addObserver:self selector:@selector(appWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    }
    return self;
}

-(void)dealloc
{
    [self stopTimer];
    [YTNotifyCenter removeObserver:self];
}

+ (instancetype)timerWithTime:(NSTimeInterval)time target:(id)aTarget selector:(SEL)aSelector repeats:(BOOL)repeats
{
    YTTimer *timer = [YTTimer new];
    timer.realTimer = [NSTimer scheduledTimerWithTimeInterval:time target:[YTWeakProxy proxyWithTarget:aTarget] selector:aSelector userInfo:nil repeats:repeats];
    timer.realTimer.fireDate = [NSDate distantFuture];
    return timer;
}


+ (instancetype)timerWithTime:(NSTimeInterval)time repeats:(BOOL)repeats block:(void (^)())block
{
    YTTimer *timer = [YTTimer new];
    if([NSTimer respondsToSelector:@selector(scheduledTimerWithTimeInterval:repeats:block:)])
    {
        timer.realTimer = [NSTimer scheduledTimerWithTimeInterval:time repeats:repeats block:block];
    }
    else
    {
        timer.realTimer = [NSTimer scheduledTimerWithTimeInterval:time
                                                           target:self
                                                         selector:@selector(blockInvoke:)
                                                         userInfo:[block copy]
                                                          repeats:repeats];
    }
    timer.realTimer.fireDate = [NSDate distantFuture];
    return timer;
}

+ (void)blockInvoke:(NSTimer *)timer {
    void (^block)() = timer.userInfo;
    if(block) {
        block();
    }
}

-(void)startTimer
{
    // app切换到后台，不自行启动定时器
    if(YTApplication.applicationState == UIApplicationStateBackground) return;
    
    _runing = YES;
    self.realTimer.fireDate = [NSDate dateWithTimeIntervalSinceNow:self.realTimer.timeInterval];
}

-(void)stopTimer
{
    _runing = NO;
    self.realTimer.fireDate = [NSDate distantFuture];
}

#pragma mark- notify
-(void)appDidEnterBackground:(NSNotification*)notify
{
    if(self.runing && !self.notObserveAppState)
    {
        // 不能调用stopTimer
        self.realTimer.fireDate = [NSDate distantFuture];
    }
}

-(void)appWillEnterForeground:(NSNotification*)notify
{
    if(self.runing && !self.notObserveAppState)
    {
        self.realTimer.fireDate = [NSDate dateWithTimeIntervalSinceNow:self.realTimer.timeInterval];
    }
}

@end

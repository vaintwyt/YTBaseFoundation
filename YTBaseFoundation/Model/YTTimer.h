//
//  YTTimer.h
//  YTBaseFoundation
//
//  Created by YT on 2018/5/3.
//  Copyright © 2018年 YT. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 app退出后台，自动停止计时；回到前台，自动开启计时
 */
@interface YTTimer : NSObject

@property (nonatomic, assign, readonly) BOOL runing;
@property (nonatomic, assign) BOOL notObserveAppState;// 不监听app前后台状态

+ (instancetype)timerWithTime:(NSTimeInterval)time target:(id)aTarget selector:(SEL)aSelector repeats:(BOOL)yesOrNo;

+ (instancetype)timerWithTime:(NSTimeInterval)time repeats:(BOOL)repeats block:(void (^)())block;

// 启动定时器后，第一次执行是在间隔时间之后
-(void)startTimer;
-(void)stopTimer;

@end

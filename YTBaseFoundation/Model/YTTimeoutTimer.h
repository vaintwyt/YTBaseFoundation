//
//  YTTimeoutTimer.h
//  YTBaseFoundation
//
//  Created by YT on 2018/5/3.
//  Copyright © 2018年 YT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTTimeoutTimer : NSObject

@property (nonatomic, assign) NSTimeInterval timeout;
@property (nonatomic, copy) void (^timeoutBlock)(void);

+(instancetype)timerWithTimeout:(NSTimeInterval)timeout block:(void (^)(void))block;

-(void)startTimeout;
-(void)stopTimeout;

@end

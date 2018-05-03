//
//  YTGCDUtil.h
//  YTBaseFoundation
//
//  Created by YT on 16/8/21.
//  Copyright © 2016年 YT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTGCDUtil : NSObject

// 异步并发执行
+(void)asyncBlock:(void (^)(void))block;

// 异步并行或串行执行
+(void)asyncBlock:(void (^)(void))block sireal:(BOOL)isSireal;

// 主线程同步
+(void)syncBlockInMain:(void (^)(void))block;
// 主线程异步
+(void)asyncBlockInMain:(void (^)(void))block;

@end

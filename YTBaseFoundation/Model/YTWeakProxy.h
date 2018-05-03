//
//  YTWeakProxy.h
//  YTBaseFoundation
//
//  Created by YT on 2018/5/3.
//  Copyright © 2018年 YT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTWeakProxy : NSProxy

@property (nonatomic, weak, readonly) id target;

- (instancetype)initWithTarget:(id)target;

+ (instancetype)proxyWithTarget:(id)target;

@end

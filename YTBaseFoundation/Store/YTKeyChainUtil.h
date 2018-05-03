//
//  YTKeyChainUtil.h
//  YTBaseFoundation
//
//  Created by YT on 16/8/21.
//  Copyright © 2016年 YT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTKeyChainUtil : NSObject


+ (NSString *)stringForKey:(NSString *)key;
+ (void)setString:(NSString *)value forKey:(NSString *)key;

+ (NSData *)dataForKey:(NSString *)key;
+ (void)setData:(NSData *)data forKey:(NSString *)key;


// encrypt
+ (NSString *)secureStringForKey:(NSString *)key;
+ (void)setSecureString:(NSString *)value forKey:(NSString *)key;

+ (NSData *)secureDataForKey:(NSString *)key;
+ (void)setSecureData:(NSData *)data forKey:(NSString *)key;


+ (void)removeItemForKey:(NSString *)key;

@end

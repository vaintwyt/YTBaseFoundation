//
//  YTAesUtil.h
//
//
//  Created by vaint on 15-3-31.
//  Copyright 2015 vaint. All rights reserved.
//


/**
 *  128key Aes 加密
 */
@interface YTAesUtil : NSObject

// BASE64输出，使用默认Key
+(NSString *)encryptString:(NSString *)srcStr;
+(NSString *)decryptString:(NSString *)encStr;

+(NSString *)encryptString:(NSString *)srcStr withKey:(NSString *)key;
+(NSString *)decryptString:(NSString *)encStr withKey:(NSString *)key;

// 使用默认Key
+(NSData *)encryptData:(NSData *)srcData;
+(NSData *)decryptData:(NSData *)encData;

+(NSData *)encryptData:(NSData *)srcData withKey:(NSString *)key;
+(NSData *)decryptData:(NSData *)encData withKey:(NSString *)key;


@end

//
//  YTAesUtil.m
//
//  Created by vaint on 15-3-31.
//  Copyright 2015 vaint. All rights reserved.
//

#import "YTAesUtil.h"
#import <CommonCrypto/CommonCryptor.h>
#import "YTSystemUtil.h"
#import "GTMBase64.h"
#import "NSString+YTAdd.h"


#define Aes_Key_Surfix @"=sl-dje%$@^83"
#define Aes_IV @"0123456789012345"

@implementation YTAesUtil

+(NSString *)encryptString:(NSString *)srcStr
{
    if(srcStr == nil) return nil;
    
    NSString *key = [NSString stringWithFormat:@"%@%@",Aes_Key_Surfix,[YTSystemUtil UDID]];
    return [self encryptString:srcStr withKey:[key MD5]];
}

+(NSString *)decryptString:(NSString *)encStr
{
    if(encStr == nil) return nil;
    
    NSString *key = [NSString stringWithFormat:@"%@%@",Aes_Key_Surfix,[YTSystemUtil UDID]];
    return [self decryptString:encStr withKey:[key MD5]];
}

+(NSData *)encryptData:(NSData *)srcData
{
    NSString *key = [NSString stringWithFormat:@"%@%@",Aes_Key_Surfix,[YTSystemUtil UDID]];
    return [self encryptData:srcData withKey:[key MD5]];
}

+(NSData *)decryptData:(NSData *)encData
{
    NSString *key = [NSString stringWithFormat:@"%@%@",Aes_Key_Surfix,[YTSystemUtil UDID]];
    return [self decryptData:encData withKey:[key MD5]];
}


+(NSString *)encryptString:(NSString *)srcStr withKey:(NSString *)key
{
    NSData *encData = [self encryptData:[srcStr dataUsingEncoding:NSUTF8StringEncoding] withKey:key];
    
    return [GTMBase64 stringByEncodingData:encData];
}

+(NSString *)decryptString:(NSString *)encStr withKey:(NSString *)key
{
    NSData *encData = [GTMBase64 decodeString:encStr];
    NSData *srcData = [self decryptData:encData withKey:key];
    
    return [[NSString alloc] initWithData:srcData encoding:NSUTF8StringEncoding];
}



+(NSData*)encryptData:(NSData*)srcData withKey:(NSString *)key
{
    if(srcData == nil) return nil;

    if(key.length <= 0) return nil;
    
    NSUInteger dataLength = [srcData length];
    size_t bufferSize = dataLength+kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          key.UTF8String, kCCKeySizeAES256,
                                          Aes_IV.UTF8String,
                                          [srcData bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}

+(NSData*)decryptData:(NSData*)encData withKey:(NSString *)key
{
    if(encData == nil) return nil;

    if(key.length <= 0) return nil;
    
    NSUInteger dataLength = [encData length];
    size_t bufferSize = dataLength+kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          key.UTF8String, kCCKeySizeAES256,
                                          Aes_IV.UTF8String,
                                          [encData bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    free(buffer);
    return nil;
}

@end

//
//  YTKeyChainUtil.m
//  YTBaseFoundation
//
//  Created by YT on 16/8/21.
//  Copyright © 2016年 YT. All rights reserved.
//

#import "YTKeyChainUtil.h"
#import "YTSystemUtil.h"
#import "YTAesUtil.h"

#define Default_Service     [YTSystemUtil appBundleId]
#define Default_AccessGroup [YTSystemUtil appBundleId]

@implementation YTKeyChainUtil

+ (void)setString:(NSString *)value forKey:(NSString *)key
{
    NSData *data = [value dataUsingEncoding:NSUTF8StringEncoding];
    [self setData:data forKey:key];
}

+ (NSString *)stringForKey:(NSString *)key
{
    NSData *data = [self dataForKey:key];
    if (data)
    {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

+ (void)setData:(NSData *)data forKey:(NSString *)key
{
    [self setData:data forKey:key encrypt:NO];
}

+ (NSData *)dataForKey:(NSString *)key
{
    return  [self dataForKey:key encrypt:NO];
}


#pragma mark- encrypt
+ (NSString *)secureStringForKey:(NSString *)key
{
    NSData *data = [self secureDataForKey:key];
    if (data)
    {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

+ (void)setSecureString:(NSString *)value forKey:(NSString *)key
{
    NSData *data = [value dataUsingEncoding:NSUTF8StringEncoding];
    [self setSecureData:data forKey:key];
}

+ (NSData *)secureDataForKey:(NSString *)key
{
    return [self dataForKey:key encrypt:YES];
}

+ (void)setSecureData:(NSData *)data forKey:(NSString *)key
{
    [self setData:data forKey:key encrypt:YES];
}



+ (NSData *)dataForKey:(NSString *)key encrypt:(BOOL)isEnc
{
    if (!key) {
        NSAssert(NO, @"key must not be nil.");
        return nil;
    }
    
    NSMutableDictionary* query = [NSMutableDictionary dictionary];
    [query setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
    [query setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [query setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    [query setObject:Default_Service forKey:(id)kSecAttrService];
    [query setObject:key forKey:(id)kSecAttrGeneric];
    [query setObject:key forKey:(id)kSecAttrAccount];
#if !TARGET_IPHONE_SIMULATOR
    [query setObject:Default_AccessGroup forKey:(id)kSecAttrAccessGroup];
    
#endif
    
    CFDataRef dataRef;
    OSStatus status = SecItemCopyMatching((CFDictionaryRef)query, (CFTypeRef *)&dataRef);
    if (status != errSecSuccess) {
        return nil;
    }
    
    NSData* retData = (__bridge NSData *)(dataRef);
    
    if(isEnc)
    {
        retData = [YTAesUtil decryptData:retData];
    }
    
    return retData;
    
}


+ (void)setData:(NSData *)data forKey:(NSString *)key encrypt:(BOOL)isEnc
{
    if(data == nil) return;
    
    if (!key) {
        NSAssert(NO, @"key must not be nil.");
        return;
    }
    
    NSData *srcData = [YTAesUtil encryptData:data];
    
    NSMutableDictionary *query = [NSMutableDictionary dictionary];
    [query setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
    [query setObject:Default_Service forKey:(id)kSecAttrService];
    [query setObject:key forKey:(id)kSecAttrGeneric];
    [query setObject:key forKey:(id)kSecAttrAccount];
#if !TARGET_IPHONE_SIMULATOR
    
    [query setObject:Default_AccessGroup forKey:(id)kSecAttrAccessGroup];
    
#endif
    
    OSStatus status = errSecSuccess;
    status = SecItemCopyMatching((CFDictionaryRef)query, NULL);
    if (status == errSecSuccess) {
        
        NSMutableDictionary *attributesToUpdate = [NSMutableDictionary dictionary];
        [attributesToUpdate setObject:srcData forKey:(id)kSecValueData];
        
        status = SecItemUpdate((CFDictionaryRef)query, (CFDictionaryRef)attributesToUpdate);
        if (status != errSecSuccess) {
            
        }
        
    } else if (status == errSecItemNotFound) {
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        [attributes setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
        [attributes setObject:Default_Service forKey:(id)kSecAttrService];
        [attributes setObject:key forKey:(id)kSecAttrGeneric];
        [attributes setObject:key forKey:(id)kSecAttrAccount];
        
        [attributes setObject:srcData forKey:(id)kSecValueData];
        
#if !TARGET_IPHONE_SIMULATOR
        
        [attributes setObject:Default_AccessGroup forKey:(id)kSecAttrAccessGroup];
        
#endif
        
        status = SecItemAdd((CFDictionaryRef)attributes, NULL);
        if (status != errSecSuccess) {
            
        }
    } else {
        
    }
}




+ (void)removeItemForKey:(NSString *)key
{
    if (!key) {
        NSAssert(NO, @"key must not be nil.");
        return;
    }
    
    NSMutableDictionary *itemToDelete = [NSMutableDictionary new];
    [itemToDelete setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
    [itemToDelete setObject:Default_Service forKey:(id)kSecAttrService];
    [itemToDelete setObject:key forKey:(id)kSecAttrGeneric];
    [itemToDelete setObject:key forKey:(id)kSecAttrAccount];
#if !TARGET_IPHONE_SIMULATOR
    
    [itemToDelete setObject:Default_AccessGroup forKey:(id)kSecAttrAccessGroup];
    
#endif
    
    OSStatus status = SecItemDelete((CFDictionaryRef)itemToDelete);
    if (status != errSecSuccess && status != errSecItemNotFound) {
        
    }
}


@end

//
//  YTFileUtil.m
//  YTBaseFoundation
//
//  Created by YT on 16/8/21.
//  Copyright © 2016年 YT. All rights reserved.
//

#import "YTFileUtil.h"

@implementation YTFileUtil

+(NSString*)documentPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

+(BOOL)delFileWithPath:(NSString*)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    [fileManager removeItemAtPath:path error:&error];
    if(error)
    {
        return NO;
    }
    
    return YES;
}

#pragma mark- plist
+(void)saveDictionary:(NSDictionary *)dict name:(NSString *)name
{
    if(dict == nil) return;
    
    NSString *filePath = [self p_plistFilePath:name];
    
    [self p_checkFilePath:filePath];
    
    [dict writeToFile:filePath atomically:YES];
}

+(NSDictionary*)dictionaryWithName:(NSString*)name
{
    NSString *filePath = [self p_plistFilePath:name];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return dict;
}

+(void)saveArray:(NSArray*)array name:(NSString *)name
{
    if(array == nil) return;
    
    NSString *filePath = [self p_plistFilePath:name];
    
    [self p_checkFilePath:filePath];
    
    [array writeToFile:filePath atomically:YES];
}

+(NSArray*)arrayWithName:(NSString*)name
{
    NSString *filePath = [self p_plistFilePath:name];
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    return array;
}

#pragma mark- image
+(BOOL)saveImage:(UIImage*)image withName:(NSString*)name
{
    return [self saveImage:image withPath:[self p_imagePath:name]];
}

+(UIImage*)imageWithName:(NSString*)name
{
    return [UIImage imageWithContentsOfFile:[self p_imagePath:name]];
}


+(BOOL)saveImage:(UIImage *)image withPath:(NSString *)path
{
    [self p_checkFilePath:path];
    
    NSData *imgData = UIImageJPEGRepresentation(image, 1);

    NSError *error;
    if(![imgData writeToFile:path options:NSDataWritingAtomic error:&error])
    {
        return NO;
    }
    return YES;
}


+(BOOL)delImageWithName:(NSString*)name
{
    return [self delFileWithPath:[self p_imagePath:name]];
}


#pragma mark- private func
// 检查目录，如果为空，则创建
+(BOOL)p_checkFilePath:(NSString*)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isExist;
    BOOL isDir;
    isExist = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    if(!isExist)
    {
        NSString *dir = path;
        if(!isDir)
        {
            NSRange range = [path rangeOfString:@"/" options:NSBackwardsSearch];
            if(range.location != NSNotFound)
            {
                dir = [path substringToIndex:range.location];
            }
        }
        NSError *error;
        [fileManager createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:&error];
        if(error)
        {
            return NO;
        }
    }
    
    return YES;
}

// 默认plist存储路径
+(NSString*)p_plistFilePath:(NSString*)name
{
    return [[self documentPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"PlistFiles/%@.plist",name]];
}

// 默认图片存储路径
+(NSString*)p_imagePath:(NSString*)name
{
    return [[self documentPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"Images/%@",name]];
}

@end

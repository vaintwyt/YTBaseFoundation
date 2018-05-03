//
//  YTFileUtil.h
//  YTBaseFoundation
//
//  Created by YT on 16/8/21.
//  Copyright © 2016年 YT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTFileUtil : NSObject

+(NSString*)documentPath;

+(BOOL)delFileWithPath:(NSString*)path;

// 存储在document的PlistFiles/name.plist文件
+(void)saveDictionary:(NSDictionary*)dict name:(NSString *)name;
+(NSDictionary*)dictionaryWithName:(NSString*)name;

+(void)saveArray:(NSArray*)array name:(NSString *)name;
+(NSArray*)arrayWithName:(NSString*)name;


/**
 *  存储图片到document的Images目录
 *
 *  @param image 图片
 *  @param name  名称，带后缀
 */
+(BOOL)saveImage:(UIImage*)image withName:(NSString*)name;
+(UIImage*)imageWithName:(NSString*)name;
+(BOOL)delImageWithName:(NSString*)name;

/**
 *  存储图片到指定路径
 *
 *  @param image     图片
 *  @param imagePath 全路径，带图片后缀
 */
+(BOOL) saveImage:(UIImage *)image withPath:(NSString *)imagePath;

@end

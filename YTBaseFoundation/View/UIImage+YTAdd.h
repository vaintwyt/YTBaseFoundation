//
//  UIImage+YTAdd.h
//  YTBaseFoundation
//
//  Created by YT on 16/8/21.
//  Copyright © 2016年 YT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YTAdd)

+(UIImage*)imageWithColor:(UIColor*)color size:(CGSize)size;

-(NSUInteger)imageCost;

-(UIImage*)scaleToSize:(CGSize)size;

+(UIImage *)addImage:(UIImage*)image to:(UIImage*)bgimage withRect:(CGRect)rect;

// 压缩图片到最大大小以内(cost单位：字节)，并且图片大小保持不小于size
-(NSData*)compressByMaxCost:(NSInteger)cost imgMinSize:(CGSize)size;

@end

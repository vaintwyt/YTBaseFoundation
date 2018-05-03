//
//  UIImage+YTAdd.m
//  YTBaseFoundation
//
//  Created by YT on 16/8/21.
//  Copyright © 2016年 YT. All rights reserved.
//

#import "UIImage+YTAdd.h"

@implementation UIImage (YTAdd)

+(UIImage*)imageWithColor:(UIColor*)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

-(NSUInteger)imageCost {
    CGImageRef cgImage = self.CGImage;
    if (!cgImage) return 0;
    CGFloat height = CGImageGetHeight(cgImage);
    size_t bytesPerRow = CGImageGetBytesPerRow(cgImage);
    NSUInteger cost = bytesPerRow * height;
    return cost;
}

-(UIImage*)scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

+(UIImage *)addImage:(UIImage*)image to:(UIImage*)bgimage withRect:(CGRect)rect
{
    if(image==nil || bgimage==nil)
    {
        return bgimage;
    }
    CGFloat scale = bgimage.scale;
    
    CGFloat bg_width = bgimage.size.width;
    CGFloat bg_height = bgimage.size.height;
    CGFloat img_width = rect.size.width;
    CGFloat img_height = rect.size.height;
    
    if(rect.origin.x < 0)
    {
        rect.origin.x = 0;
    }
    if(rect.origin.y < 0)
    {
        rect.origin.y = 0;
    }
    
    if(bg_width<img_width || bg_height<img_height)
    {
        return nil;
    }
    
    CGColorSpaceRef colorSpace;
    colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate (NULL,
                                                  scale*bg_width, scale*bg_height,
                                                  8,0, colorSpace, kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colorSpace);
    CGContextScaleCTM(context, scale, scale);
    CGContextDrawImage(context, CGRectMake(0, 0, bg_width, bg_height), bgimage.CGImage);
    CGContextDrawImage(context, rect, image.CGImage);
    
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    
    UIImage * mergedimage = [UIImage imageWithCGImage:imageRef scale:scale orientation:UIImageOrientationUp];
    if(imageRef)
    {
        CGImageRelease(imageRef);
    }
    return mergedimage;
}


-(NSData*)compressByMaxCost:(NSInteger)cost imgMinSize:(CGSize)size
{
    if([self imageCost] < cost)
        return UIImageJPEGRepresentation(self, 1);
    
    CGFloat compress = 0.7;
    NSData *data = UIImageJPEGRepresentation(self, compress);
    if(data.length < cost)
        return data;
    
    CGFloat width = self.size.width*self.scale;
    CGFloat height = self.size.height*self.scale;
    
    UIImage *compressImg = self;
    if(width > size.width || height > size.height)// 缩小分辨率
    {
        CGFloat imgRatio = width/height;
        CGFloat minSizeRatio = size.width/size.height;
        
        if(imgRatio < minSizeRatio){
            imgRatio = size.height / height;
            width = imgRatio * width;
            height = size.height;
        }
        else if(imgRatio > minSizeRatio){
            imgRatio = size.width / width;
            height = imgRatio * height;
            width = size.width;
        }
        else{
            height = size.height;
            width = size.width;
        }
        
        CGRect rect = CGRectMake(0, 0, width, height);
        UIGraphicsBeginImageContext(rect.size);
        [self drawInRect:rect];
        compressImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    
    
    CGFloat maxCompress = 0.1;
    data = UIImageJPEGRepresentation(compressImg, compress);
    while ([data length] > cost && compress > maxCompress)
    {
        compress -= 0.1;
        
        data = UIImageJPEGRepresentation(compressImg, compress);
    }
    return data;
}

@end

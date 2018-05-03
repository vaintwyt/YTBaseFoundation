//
//  NSString+YTAdd.m
//  YTBaseFoundation
//
//  Created by YT on 16/8/21.
//  Copyright © 2016年 YT. All rights reserved.
//

#import "NSString+YTAdd.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (YTAdd)

@end



#pragma mark- View
@implementation NSString (View)

-(CGSize)sizeWithFont:(UIFont *)font
{
    if(nil == font)return CGSizeZero;
    
    CGSize size  = [self boundingRectWithSize:CGSizeMake(NSIntegerMax, NSIntegerMax)
                                      options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                   attributes:@{NSFontAttributeName:font}
                                      context:nil].size;
    return size;
    
}

- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)constrainSize
{
    if (font == nil) return CGSizeZero;
    
    CGSize size  = [self boundingRectWithSize:constrainSize
                                      options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                   attributes:@{NSFontAttributeName:font}
                                      context:nil].size;
    return size;
}

@end


#pragma mark- Digital
@implementation NSString (Digital)

-(NSString *)MD5
{
    const char *src = [self UTF8String];
    unsigned char ret[CC_MD5_DIGEST_LENGTH];
    CC_MD5(src, (unsigned int)strlen(src), ret);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [hash appendFormat:@"%02X", ret[i]];
    return hash;
}

- (BOOL)isIntValue
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

// 是否浮点数，包含整数
- (BOOL)isFloatValue
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

-(BOOL)isLetterValue
{
    BOOL ret = YES;
    NSString *tmp = [self lowercaseString];
    for(int i=0; i<tmp.length; i++)
    {
        int ch = [tmp characterAtIndex:i];
        
        ret = ch >= 'a' && ch <= 'z';
        if(!ret)
        {
            break;
        }
        
    }
    return ret;
}


-(BOOL)isChineseValue
{
    BOOL ret = YES;
    for(int i=0; i<self.length; i++)
    {
        int a = [self characterAtIndex:i];
        
        ret = a >= 0x4e00 && a <= 0x9fff;
        if(!ret)
            break;
    }
    return ret;
}


-(BOOL)isIDCard
{
    //只有18位的身份证才有校验码
    if(self.length != 18)
    {
        return YES;
    }
    
    NSString *idCard = [self uppercaseString];
    
    int tSub[] = { 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    char tRes[] = { '1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2' };
    int sum = 0, tmpInt = 0;
    for (int i = 0; i < idCard.length - 1; i++) {
        NSRange range;
        range.location = i;
        range.length = 1;
        tmpInt = [[idCard substringWithRange:range] intValue];
        
        tmpInt *= tSub[i];
        sum += tmpInt;
    }
    tmpInt = sum % 11;
    NSString* strResult =  [idCard substringFromIndex:17];
    const char* pstrResult = [strResult UTF8String];
    char s = pstrResult[0];
    
    if (s != tRes[tmpInt]) {
        return NO;
    }
    return YES;
    
}

-(BOOL)isPhone
{
    //    电信号段:133/153/180/181/189/177
    //    联通号段:130/131/132/155/156/185/186/145/176
    //    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
    //    虚拟运营商:170
    
    NSString *regex = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [predicate evaluateWithObject:self];
}

-(NSString*)removeSpace
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *retStr = [self stringByTrimmingCharactersInSet:whitespace];
    retStr = [retStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    return retStr;
}


@end



#pragma mark- HTTP
@implementation NSString (HTTP)

-(NSString *)urlDecode
{
    CFStringRef decodedCFString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,(__bridge CFStringRef) self,CFSTR(""),kCFStringEncodingUTF8);
    
    NSString *decodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString*) decodedCFString];
    return (!decodedString) ? @"" : [decodedString stringByReplacingOccurrencesOfString:@"+" withString:@" "];
}

-(NSString*)urlEncode
{
    CFStringRef encodedCFString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(__bridge CFStringRef) self,nil,CFSTR("?!@#$^&%*+,:;='\"`<>()[]{}/\\| "),kCFStringEncodingUTF8);
    
    NSString *encodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString*) encodedCFString];
    
    if(!encodedString)
        encodedString = @"";
    
    return encodedString;
}

-(NSDictionary*)dictionaryFromParamString
{
    if(self.length <= 0)
        return nil;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSArray *pairs = [[self urlDecode] componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        NSArray *keyValue = [pair componentsSeparatedByString:@"="];
        if(keyValue.count != 2)
            continue;
        
        [dict setValue:keyValue[1] forKey:keyValue[0]];
    }
    return dict;
}

@end

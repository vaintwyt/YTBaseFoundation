//
//  NSString+YTAdd.h
//  YTBaseFoundation
//
//  Created by vaint on 16/8/21.
//  Copyright © 2016年 vaint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YTAdd)

@end

@interface NSString (View)

- (CGSize)sizeWithFont:(UIFont *)font;
- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)constrainSize;

@end

@interface NSString (Digital)

-(NSString*)MD5;

-(BOOL)isIntValue;
-(BOOL)isFloatValue;
-(BOOL)isLetterValue;
-(BOOL)isChineseValue;

-(BOOL)isIDCard;
-(BOOL)isPhone;

-(NSString*)removeSpace;

@end


@interface NSString (HTTP)

-(NSString*)urlDecode;
-(NSString*)urlEncode;

-(NSDictionary*)dictionaryFromParamString;

@end

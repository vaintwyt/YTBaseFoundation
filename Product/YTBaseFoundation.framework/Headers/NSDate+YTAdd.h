//
//  NSDate+YTAdd.h
//  YTBaseFoundation
//
//  Created by vaint on 16/8/21.
//  Copyright © 2016年 vaint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YTAdd)

+(NSDate*)dateFromString:(NSString*)dateStr format:(NSString*)format;
+(NSString*)stringFromDate:(NSDate*)date format:(NSString*)format;

// 正数为之后日期，负数为之前日期
- (NSDate *)dateAfterDay:(NSInteger)day;
- (NSDate *)dateAfterMonth:(NSInteger)month;

- (NSDate*)dateWithHour:(NSInteger)hour minute:(NSInteger)minute;

- (NSInteger)getDay;
- (NSInteger)getMonth;
- (NSInteger)getYear;
- (NSInteger)getHour;
- (NSInteger)getMinute;


-(BOOL)isToday;
-(NSInteger)dayBeforeDate:(NSDate*)date;

@end

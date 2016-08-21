//
//  NSDate+YTAdd.m
//  YTBaseFoundation
//
//  Created by vaint on 16/8/21.
//  Copyright © 2016年 vaint. All rights reserved.
//

#import "NSDate+YTAdd.h"

@implementation NSDate (YTAdd)

+(NSDate*)dateFromString:(NSString*)dateStr format:(NSString*)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone localTimeZone];
    [formatter setDateFormat:format];
    
    return [formatter dateFromString:dateStr];
}

+(NSString*)stringFromDate:(NSDate*)date format:(NSString*)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone localTimeZone];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}


- (NSDate *)dateAfterDay:(NSInteger)day
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:day];
    
    NSDate *date = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    
    return date;
}

- (NSDate *)dateAfterMonth:(NSInteger)month
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    
    NSDate *date = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    return date;
}


-(NSDate *)dateWithHour:(NSInteger)hour minute:(NSInteger)minute
{
    NSCalendar *curCalendar = [NSCalendar currentCalendar];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    
    NSDateComponents *curComps = [curCalendar components:unitFlags fromDate:self];
    curComps.hour = hour;
    curComps.minute = minute;
    
    NSCalendar *retCalendar = [NSCalendar currentCalendar];
    return [retCalendar dateFromComponents:curComps];
    
}


- (NSInteger)getDay
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitDay fromDate:self];
    components.timeZone = [NSTimeZone localTimeZone];
    return components.day;
    
}

- (NSInteger)getMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth fromDate:self];
    components.timeZone = [NSTimeZone localTimeZone];
    return components.month;
    
}

- (NSInteger)getYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:self];
    components.timeZone = [NSTimeZone localTimeZone];
    return components.year;
    
}


- (NSInteger)getHour
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitHour fromDate:self];
    components.timeZone = [NSTimeZone localTimeZone];
    return components.hour;
    
}

- (NSInteger)getMinute
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitMinute fromDate:self];
    components.timeZone = [NSTimeZone localTimeZone];
    return components.minute;
}


-(BOOL)isToday
{
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
//    
//    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
//    nowCmps.timeZone = [NSTimeZone localTimeZone];
//    
//    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
//    selfCmps.timeZone = [NSTimeZone localTimeZone];
//    
//    return (selfCmps.year == nowCmps.year)
//    && (selfCmps.month == nowCmps.month)
//    && (selfCmps.day == nowCmps.day);
    return [self dayBeforeDate:[NSDate date]] == 0;
    
}

-(NSInteger)dayBeforeDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *fromDate;
    NSDate *toDate;
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:self];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:date];
    NSDateComponents *dayComp = [calendar components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
    
    return dayComp.day;
}

@end

//
//  NSMutableURLRequest+YTAdd.h
//  YTBaseFoundation
//
//  Created by vaint on 16/8/23.
//  Copyright © 2016年 vaint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableURLRequest (YTAdd)

+(NSMutableURLRequest*)URLRequestWithPath:(NSString*)path
                                   method:(NSString*)method
                                   params:(NSDictionary*)params
                                httpHeads:(NSDictionary*)httpHeads
                                   cookie:(NSString*)cookie;

@end

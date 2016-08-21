//
//  YTBaseFoundation.h
//  YTBaseFoundation
//
//  Created by vaint on 16/8/21.
//  Copyright © 2016年 vaint. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for YTBaseFoundation.
FOUNDATION_EXPORT double YTBaseFoundationVersionNumber;

//! Project version string for YTBaseFoundation.
FOUNDATION_EXPORT const unsigned char YTBaseFoundationVersionString[];



// System
#define YTUserDefaults [NSUserDefaults standardUserDefaults]
#define YTNotifyCenter [NSNotificationCenter defaultCenter]
#define YTApplication  [UIApplication sharedApplication]




// Custom
#define YTWeakSelf(_weakSelf)                 __weak typeof(self) _weakSelf = self
#define YTStrongSelf(_strongSelf,_weakSelf)   __typeof(&*_weakSelf) _strongSelf = _weakSelf

#define YTDefine_Extern_String(key) extern NSString* const k##key
#define YTInit_Extern_String(key, value) NSString* const k##key=@""#value

#define YTDefine_SharedInstance(className) \
\
+ (instancetype)sharedInstance { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}




#ifdef DEBUG

#define DebugLog(fmt, ...) NSLog((@"%s %3d:\n" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#else

#define DebugLog(fmt, ...)

#endif


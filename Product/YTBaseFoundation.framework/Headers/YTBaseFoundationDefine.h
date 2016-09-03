//
//  YTBaseFoundationDefine.h
//  YTBaseFoundation
//
//  Created by vaint on 16/8/28.
//  Copyright © 2016年 vaint. All rights reserved.
//

#ifndef YTBaseFoundationDefine_h
#define YTBaseFoundationDefine_h


// System
#define YTUserDefaults [NSUserDefaults standardUserDefaults]
#define YTNotifyCenter [NSNotificationCenter defaultCenter]
#define YTApplication  [UIApplication sharedApplication]




// Custom
#define YTWeakSelf(_weakSelf)                 __weak typeof(self) _weakSelf = self
#define YTStrongSelf(_strongSelf,_weakSelf)   __typeof(&*_weakSelf) _strongSelf = _weakSelf

#define YTDefine_Extern_String(key) extern NSString* const k##key
#define YTInit_Extern_String(key, value) NSString* const k##key=@""#value

#define YTSharedInstance +(instancetype)sharedInstance
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


#endif /* YTBaseFoundationDefine_h */

//
//  YTBaseFoundationDefine.h
//  YTBaseFoundation
//
//  Created by YT on 16/8/28.
//  Copyright © 2016年 YT. All rights reserved.
//

#ifndef YTBaseFoundationDefine_h
#define YTBaseFoundationDefine_h


// System
#define YTUserDefaults [NSUserDefaults standardUserDefaults]
#define YTNotifyCenter [NSNotificationCenter defaultCenter]
#define YTApplication  [UIApplication sharedApplication]




// Custom
#define YTWeakSelf                 __weak typeof(self) wSelf = self;
#define YTStrongSelf   __typeof(&*wSelf) sSelf = wSelf;
#define YTStrongSelfNotNil  \
YTStrongSelf \
if(!sSelf) return;

#define YTStrongSelfNotNil_R(_retVal_)   \
YTStrongSelf \
if(!sSelf) return _retVal_;


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

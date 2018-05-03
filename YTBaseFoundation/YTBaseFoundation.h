//
//  YTBaseFoundation.h
//  YTBaseFoundation
//
//  Created by YT on 16/8/21.
//  Copyright © 2016年 YT. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for YTBaseFoundation.
FOUNDATION_EXPORT double YTBaseFoundationVersionNumber;

//! Project version string for YTBaseFoundation.
FOUNDATION_EXPORT const unsigned char YTBaseFoundationVersionString[];

#if __has_include(<YTBaseFoundation/YTBaseFoundation.h>)

#import <YTBaseFoundation/YTBaseFoundationDefine.h>
#import <YTBaseFoundation/YTNetwork.h>
#import <YTBaseFoundation/YTView.h>
#import <YTBaseFoundation/YTGCDUtil.h>
#import <YTBaseFoundation/YTModel.h>
#import <YTBaseFoundation/YTFileUtil.h>
#import <YTBaseFoundation/YTKeyChainUtil.h>
#import <YTBaseFoundation/YTAesUtil.h>
#import <YTBaseFoundation/YTSystemUtil.h>

#else

#import "YTBaseFoundationDefine.h"
#import "YTNetwork.h"
#import "YTView.h"
#import "YTGCDUtil.h"
#import "YTModel.h"
#import "YTFileUtil.h"
#import "YTKeyChainUtil.h"
#import "YTAesUtil.h"
#import "YTSystemUtil.h"

#endif


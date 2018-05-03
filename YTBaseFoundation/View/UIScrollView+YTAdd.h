//
//  UIScrollView+YTAdd.h
//  YTBaseFoundation
//
//  Created by YT on 16/11/27.
//  Copyright © 2016年 YT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (YTAdd)

- (BOOL)isScrollToTop;
- (void)scrollToTop;// 带有动画
- (void)scrollToTopAnimated:(BOOL)animated;


- (BOOL)isScrollToBottom;
- (void)scrollToBottom;// 带有动画
- (void)scrollToBottomAnimated:(BOOL)animated;

@end

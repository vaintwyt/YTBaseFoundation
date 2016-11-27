//
//  UIScrollView+YTAdd.m
//  YTBaseFoundation
//
//  Created by vaint on 16/11/27.
//  Copyright © 2016年 vaint. All rights reserved.
//

#import "UIScrollView+YTAdd.h"

@implementation UIScrollView (YTAdd)

- (BOOL)isScrollToTop
{
    CGPoint offset = self.contentOffset;
    return (offset.y == -self.contentInset.top);
}

-(void)scrollToTop
{
    [self scrollToTopAnimated:YES];
}

- (void)scrollToTopAnimated:(BOOL)animated
{
    CGPoint offset = self.contentOffset;
    offset.y = 0 - self.contentInset.top;
    [self setContentOffset:offset animated:animated];
}


- (BOOL)isScrollToBottom
{
    CGPoint offset = self.contentOffset;
    return (offset.y == (self.contentSize.height - self.bounds.size.height + self.contentInset.bottom));
}

-(void)scrollToBottom
{
    [self scrollToTopAnimated:YES];
}

- (void)scrollToBottomAnimated:(BOOL)animated
{
    CGPoint offset = self.contentOffset;
    offset.y = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom;
    [self setContentOffset:offset animated:animated];
}

@end

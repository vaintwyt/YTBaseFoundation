//
//  UITableView+YTAdd.m
//  YTBaseFoundation
//
//  Created by YT on 16/11/27.
//  Copyright © 2016年 YT. All rights reserved.
//

#import "UITableView+YTAdd.h"

@implementation UITableView (YTAdd)

- (void)updateWithBlock:(void (^)(UITableView *tableView))block {
    [self beginUpdates];
    block(self);
    [self endUpdates];
}

@end

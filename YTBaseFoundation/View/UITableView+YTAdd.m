//
//  UITableView+YTAdd.m
//  YTBaseFoundation
//
//  Created by vaint on 16/11/27.
//  Copyright © 2016年 vaint. All rights reserved.
//

#import "UITableView+YTAdd.h"

@implementation UITableView (YTAdd)

- (void)updateWithBlock:(void (^)(UITableView *tableView))block {
    [self beginUpdates];
    block(self);
    [self endUpdates];
}

@end

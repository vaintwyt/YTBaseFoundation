//
//  UITableView+YTAdd.h
//  YTBaseFoundation
//
//  Created by YT on 16/11/27.
//  Copyright © 2016年 YT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (YTAdd)

- (void)updateWithBlock:(void (^)(UITableView *tableView))block;

@end

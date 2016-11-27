//
//  UITableView+YTAdd.h
//  YTBaseFoundation
//
//  Created by vaint on 16/11/27.
//  Copyright © 2016年 vaint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (YTAdd)

- (void)updateWithBlock:(void (^)(UITableView *tableView))block;

@end

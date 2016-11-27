//
//  CALayer+YTAdd.h
//  YTBaseFoundation
//
//  Created by vaint on 16/11/27.
//  Copyright © 2016年 vaint. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (YTAdd)

// ---- 基本属性
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;

@property (nonatomic, readonly) CGPoint bottomLeft;
@property (nonatomic, readonly) CGPoint bottomRight;
@property (nonatomic, readonly) CGPoint topRight;

@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat width;

@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat left;

@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat right;

@property (nonatomic) CGPoint center;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

@end

//
//  UIView+YTAdd.h
//  YTBaseFoundation
//
//  Created by YT on 16/8/21.
//  Copyright © 2016年 YT. All rights reserved.
//



@interface UIView (Frame)

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

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;


// ---- 布局
- (void)heightEqualToView:(UIView *)view;
- (void)widthEqualToView:(UIView *)view;

// center
- (void)centerXEqualToView:(UIView *)view;
- (void)centerYEqualToView:(UIView *)view;
- (void)centerInView:(UIView *)view;

// 相对于view的间距
- (void)top:(CGFloat)top ofView:(UIView *)view;
- (void)bottom:(CGFloat)bottom ofView:(UIView *)view;
- (void)left:(CGFloat)left ofView:(UIView *)view;
- (void)right:(CGFloat)right ofView:(UIView *)view;

// 在父view内改变padding，shouldResize为YES将会同步改变宽高
- (void)topInContainer:(CGFloat)top shouldResize:(BOOL)shouldResize;
- (void)bottomInContainer:(CGFloat)bottom shouldResize:(BOOL)shouldResize;
- (void)leftInContainer:(CGFloat)left shouldResize:(BOOL)shouldResize;
- (void)rightInContainer:(CGFloat)right shouldResize:(BOOL)shouldResize;

// 与view对齐
- (void)topEqualToView:(UIView *)view;
- (void)bottomEqualToView:(UIView *)view;
- (void)leftEqualToView:(UIView *)view;
- (void)rightEqualToView:(UIView *)view;
- (void)originEqualToView:(UIView *)view;

- (void)sizeEqualToView:(UIView *)view;

- (void)fillWidth;
- (void)fillHeight;
- (void)fill;

- (UIView *)topSuperView;


@end






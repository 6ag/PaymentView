//
//  WSPaymentCircleView.m
//  PayChinaPospIOS
//
//  Created by zhoujianfeng on 16/5/16.
//  Copyright © 2016年 paychina. All rights reserved.
//

#import "WSPaymentCircleView.h"
#import "WSPaymentOther.h"

#define kDegreesToRadians(degrees) ((3.14159265359 * degrees) / 180)

@interface WSPaymentCircleView ()
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) double add;
@property (nonatomic, assign) CGFloat myRadius;
@property (nonatomic, strong) UIBezierPath *path;

@end

@implementation WSPaymentCircleView

/**
 *  配置图层
 */
- (void)setupShapeLayer
{
    [self cleanLayer];
    
    self.myRadius = self.frame.size.width * 0.5;
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.frame = self.frame;
    self.shapeLayer.position = CGPointMake(self.myRadius, self.myRadius);
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.shapeLayer.lineWidth = 3.0f;
    self.shapeLayer.strokeColor = kCircleColor.CGColor;
    self.shapeLayer.lineCap = @"round";
    self.shapeLayer.lineJoin = @"round";
    self.shapeLayer.strokeStart = 0;
    self.shapeLayer.strokeEnd = 0;
}

/**
 *  配置动画
 */
- (void)setupAnimationWithPath:(CGPathRef)path loadSelector:(SEL)loadSelector interval:(CGFloat)interval
{
    self.shapeLayer.path = path;
    self.add = interval;
    [self.layer addSublayer:self.shapeLayer];
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:loadSelector];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

/**
 *  正在加载动画
 */
- (void)loadingAnimation
{
    if (self.shapeLayer.strokeEnd > 1 && self.shapeLayer.strokeStart < 1) {
        self.shapeLayer.strokeStart += self.add;
    } else if(self.shapeLayer.strokeStart == 0){
        self.shapeLayer.strokeEnd += self.add;
    }
    
    if (self.shapeLayer.strokeEnd == 0) {
        self.shapeLayer.strokeStart = 0;
    }
    
    if (self.shapeLayer.strokeStart == self.shapeLayer.strokeEnd) {
        self.shapeLayer.strokeEnd = 0;
    }
}

/**
 *  成功或失败的动画
 */
- (void)successOrFailedAnimation
{
    if (self.shapeLayer.strokeEnd <= 1) {
        self.shapeLayer.strokeEnd += self.add;
    } else {
        [self removeDisplayLink];
    }
}

/**
 *  清楚图层
 */
- (void)cleanLayer
{
    [self removeDisplayLink];
    [self.shapeLayer removeFromSuperlayer];
    self.shapeLayer = nil;
}

/**
 *  移除定时器
 */
- (void)removeDisplayLink
{
    [self.displayLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [self.displayLink invalidate];
    self.displayLink = nil;
}

/**
 *  加载状态
 *
 *  @param status 状态
 */
- (void)loadStatus:(WSLoadStatus)status
{
    // 配置图层
    [self setupShapeLayer];
    
    switch (status) {
        case WSLoadStatusLoading: {
            
            self.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(1.5, 1.5, self.myRadius * 2 - 3, self.myRadius * 2 - 3)];
            [self setupAnimationWithPath:self.path.CGPath loadSelector:@selector(loadingAnimation) interval:0.01];
        }
            break;
        case WSLoadStatusSuccess: {
            
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(10, 35)];
            [path addLineToPoint:CGPointMake(35, 55)];
            [path addLineToPoint:CGPointMake(60, 35)];
            
            [self.path appendPath:path];
            [self setupAnimationWithPath:self.path.CGPath loadSelector:@selector(successOrFailedAnimation) interval:0.015];
        }
            break;
        case WSLoadStatusFailed: {
            
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(20, 20)];
            [path addLineToPoint:CGPointMake(50, 50)];
            
            UIBezierPath *path1 = [UIBezierPath bezierPath];
            [path1 moveToPoint:CGPointMake(50, 20)];
            [path1 addLineToPoint:CGPointMake(20, 50)];
            
            [self.path appendPath:path];
            [self.path appendPath:path1];
            [self setupAnimationWithPath:self.path.CGPath loadSelector:@selector(successOrFailedAnimation) interval:0.015];
        }
            break;
        default:
            break;
    }
}

@end

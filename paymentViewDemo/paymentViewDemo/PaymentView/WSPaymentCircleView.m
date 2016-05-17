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
@property (nonatomic, strong) NSTimer *timer;
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
    self.add = 0.1;
}

/**
 *  配置动画
 */
- (void)setupAnimationWithPath:(CGPathRef)path loadSelector:(SEL)loadSelector interval:(CGFloat)interval
{
    self.shapeLayer.path = path;
    [self.layer addSublayer:self.shapeLayer];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:loadSelector userInfo:nil repeats:YES];
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
        [self removeTimer];
    }
}

/**
 *  清楚图层
 */
- (void)cleanLayer
{
    [self removeTimer];
    [self.shapeLayer removeFromSuperlayer];
    self.shapeLayer = nil;
}

/**
 *  移除定时器
 */
- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
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
            [self setupAnimationWithPath:self.path.CGPath loadSelector:@selector(loadingAnimation) interval:0.1];
        }
            break;
        case WSLoadStatusSuccess: {
            
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(10, 35)];
            [path addLineToPoint:CGPointMake(35, 55)];
            [path addLineToPoint:CGPointMake(60, 35)];
            
            [self.path appendPath:path];
            [self setupAnimationWithPath:self.path.CGPath loadSelector:@selector(successOrFailedAnimation) interval:0.15];
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
            [self setupAnimationWithPath:self.path.CGPath loadSelector:@selector(successOrFailedAnimation) interval:0.15];
        }
            break;
        default:
            break;
    }
}

@end

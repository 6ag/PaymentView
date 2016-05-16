//
//  WSPaymentView.m
//  PayChinaPospIOS
//
//  Created by zhoujianfeng on 16/4/21.
//  Copyright © 2016年 zhoujianfeng. All rights reserved.
//

#import "WSPaymentView.h"
#import "WSPaymentDetailView.h"
#import "WSPaymentPasswordView.h"
#import "WSPaymentResultView.h"

@interface WSPaymentView () <WSPaymentPasswordViewDelegate, WSPaymentDetailViewDelegate, WSPaymentResultViewDelegate>

@property (nonatomic, strong) UIView *bgView;                             // 载体背景视图
@property (nonatomic, strong) WSPaymentDetailView *paymentDetailView;     // 付款详情视图
@property (nonatomic, strong) WSPaymentPasswordView *paymentPasswordView; // 付款密码视图
@property (nonatomic, strong) WSPaymentResultView *paymentResultView;     // 付款结果视图

@property (nonatomic, assign) WSPaymentMethod paymentMethod;
@property (nonatomic, copy) NSString *detailInfo;
@property (nonatomic, copy) NSString *money;
@end

@implementation WSPaymentView

- (instancetype)initWithInfo:(NSString *)info money:(NSString *)money paymentMethod:(WSPaymentMethod)paymentMethod
{
    if (self = [super init]) {
        self.paymentMethod = paymentMethod;
        self.detailInfo = info;
        self.money = money;
    }
    return self;
}

/**
 *  显示付款视图
 */
- (void)show
{
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    self.frame = kScreenBounds;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth * 3, kScreenHeight - 250)];
    [[UIApplication sharedApplication].keyWindow addSubview:self.bgView];
    
    // 付款选择视图
    self.paymentDetailView = [[[NSBundle mainBundle] loadNibNamed:@"WSPaymentDetailView" owner:nil options:nil] lastObject];
    self.paymentDetailView.delegate = self;
    self.paymentDetailView.moneyLabel.text = self.money;
    self.paymentDetailView.detailLabel.text = self.detailInfo;
    if (self.paymentMethod == WSPaymentMethodOnline) {
        [self.paymentDetailView didSelectUnionPayButton:self.paymentDetailView.unityPayButton];
    } else {
        [self.paymentDetailView didSelectBalancePayButton:self.paymentDetailView.balanceButton];
    }
    self.paymentDetailView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 250);
    [self.bgView addSubview:self.paymentDetailView];
    
    // 密码输入视图
    self.paymentPasswordView = [[[NSBundle mainBundle] loadNibNamed:@"WSPaymentPasswordView" owner:nil options:nil] lastObject];
    self.paymentPasswordView.delegate = self;
    self.paymentPasswordView.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight - 250);
    [self.bgView addSubview:self.paymentPasswordView];
    
    // 付款结果视图
    self.paymentResultView = [[[NSBundle mainBundle] loadNibNamed:@"WSPaymentResultView" owner:nil options:nil] lastObject];
    self.paymentResultView.delegate = self;
    self.paymentResultView.frame = CGRectMake(kScreenWidth * 2, 0, kScreenWidth, kScreenHeight - 250);
    [self.bgView addSubview:self.paymentResultView];
    
    // 动画弹出详情视图
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.transform = CGAffineTransformTranslate(self.bgView.transform, 0, -(kScreenHeight - 250));
    }];
}

/**
 *  销毁付款视图
 */
- (void)dismiss
{
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.transform = CGAffineTransformTranslate(self.bgView.transform, 0, kScreenHeight - 250);
    } completion:^(BOOL finished) {
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
        
        self.paymentMethod = 0;
        self.detailInfo = nil;
        self.money = nil;
    }];
}

/**
 *  付款结果
 *
 *  @param result YES为成功
 *  @param message 提示信息
 */
- (void)paymentResult:(BOOL)result message:(NSString *)message
{
    if (result) {
        // 显示成功UI
        self.paymentResultView.resultLabel.text = message;
        [self.paymentResultView.loadView loadStatus:WSLoadStatusSuccess];
    } else {
        // 显示失败UI
        self.paymentResultView.resultLabel.text = message;
        [self.paymentResultView.loadView loadStatus:WSLoadStatusFailed];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([message isEqualToString:@"当前支付密码不正确"]) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"付款失败" message:message delegate:self cancelButtonTitle:@"取消付款" otherButtonTitles:@"重新输入", nil];
                [alertView show];
            }
        });
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        // 取消
        [self dismiss];
        if ([self.delegate respondsToSelector:@selector(paymentComplete)]) {
            [self.delegate paymentComplete];
        }
    } else if (buttonIndex == 1) {
        // 重新输入
        [UIView animateWithDuration:0.25 animations:^{
            self.bgView.transform = CGAffineTransformTranslate(self.bgView.transform, kScreenWidth, 0);
        } completion:^(BOOL finished) {
            [self.paymentPasswordView.passwordField becomeFirstResponder];
        }];
    }
}

#pragma mark - WSPaymentDetailViewDelegate
/**
 *  点击了详情视图的确认支付
 */
- (void)didTappedDetailViewConfirmButtonWithPaymentMethod:(WSPaymentMethod)paymentMethod
{
    self.paymentMethod = paymentMethod;
    if (paymentMethod == WSPaymentMethodOnline) {
        // 在线支付直接回调
        [self dismiss];
        if ([self.delegate respondsToSelector:@selector(didTappedConfirmButtonWithPaymentMethod:paymentPassword:)]) {
            [self.delegate didTappedConfirmButtonWithPaymentMethod:paymentMethod paymentPassword:nil];
        }
    } else {
        // 余额支付跳转到密码视图
        [UIView animateWithDuration:0.25 animations:^{
            self.bgView.transform = CGAffineTransformTranslate(self.bgView.transform, -kScreenWidth, 0);
        } completion:^(BOOL finished) {
            [self.paymentPasswordView.passwordField becomeFirstResponder];
        }];
    }
}

/**
 *  点击了详情视图的关闭按钮
 */
- (void)didTappedDetailViewCloseButton
{
    [self dismiss];
    if ([self.delegate respondsToSelector:@selector(didTappedColseButton)]) {
        [self.delegate didTappedColseButton];
    }
}

#pragma mark - WSPaymentPasswordViewDelegate
/**
 *  点击了密码视图的付款按钮
 */
- (void)didTappedPasswordViewConfirmButtonWithPaymentPassword:(NSString *)paymentPassword
{
    [self.paymentResultView.loadView cleanLayer];
    self.paymentResultView.resultLabel.text = @"正在付款...";
    [self.paymentResultView.loadView loadStatus:WSLoadStatusLoading];
    
    // 动画偏移视图，显示出支付详情视图
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.transform = CGAffineTransformTranslate(self.bgView.transform, -kScreenWidth, 0);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 回调支付密码
        if ([self.delegate respondsToSelector:@selector(didTappedConfirmButtonWithPaymentMethod:paymentPassword:)]) {
            [self.delegate didTappedConfirmButtonWithPaymentMethod:self.paymentMethod paymentPassword:paymentPassword];
        }
    });
}

/**
 *  点击了密码视图的返回按钮
 */
- (void)didTappedPasswordViewBackButton
{
    // 动画偏移视图，显示出支付详情视图
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.transform = CGAffineTransformTranslate(self.bgView.transform, kScreenWidth, 0);
    }];
}

/**
 *  点击了密码视图的忘记密码
 */
- (void)didTappedPasswordViewForgetPasswordButton
{
    [self dismiss];
    if ([self.delegate respondsToSelector:@selector(didTappedForgetPasswordButton)]) {
        [self.delegate didTappedForgetPasswordButton];
    }
}

#pragma mark - WSPaymentResultViewDelegate
/**
 *  点击了结果视图的确定按钮
 */
- (void)didTappedResultViewConfirmButton
{
    [self dismiss];
    if ([self.delegate respondsToSelector:@selector(paymentComplete)]) {
        [self.delegate paymentComplete];
    }
}

/**
 *  点击了结果视图的返回按钮
 */
- (void)didTappedResultViewBackButton
{
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.transform = CGAffineTransformTranslate(self.bgView.transform, kScreenWidth, 0);
    } completion:^(BOOL finished) {
        [self.paymentPasswordView.passwordField becomeFirstResponder];
    }];
}

@end

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

@interface WSPaymentView () <WSPaymentPasswordViewDelegate, WSPaymentDetailViewDelegate>

@property (nonatomic, strong) WSPaymentDetailView *paymentDetailView;     // 付款详情视图
@property (nonatomic, strong) WSPaymentPasswordView *paymentPasswordView; // 付款密码视图

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
    
    self.paymentDetailView = [[[NSBundle mainBundle] loadNibNamed:@"WSPaymentDetailView" owner:nil options:nil] lastObject];
    self.paymentDetailView.delegate = self;
    self.paymentDetailView.moneyLabel.text = self.money;
    self.paymentDetailView.detailLabel.text = self.detailInfo;
    if (self.paymentMethod == WSPaymentMethodOnline) {
        [self.paymentDetailView didSelectUnionPayButton:self.paymentDetailView.unityPayButton];
    } else {
        [self.paymentDetailView didSelectBalancePayButton:self.paymentDetailView.balanceButton];
    }
    self.paymentDetailView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight - 250);
    [[UIApplication sharedApplication].keyWindow addSubview:self.paymentDetailView];
    
    self.paymentPasswordView = [[[NSBundle mainBundle] loadNibNamed:@"WSPaymentPasswordView" owner:nil options:nil] lastObject];
    self.paymentPasswordView.delegate = self;
    self.paymentPasswordView.frame = CGRectMake(kScreenWidth, kScreenHeight, kScreenWidth, kScreenHeight - 250);
    [[UIApplication sharedApplication].keyWindow addSubview:self.paymentPasswordView];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.paymentDetailView.transform = CGAffineTransformTranslate(self.paymentDetailView.transform, 0, -(kScreenHeight - 250));
        self.paymentPasswordView.transform = CGAffineTransformTranslate(self.paymentPasswordView.transform, 0, -(kScreenHeight - 250));
    }];
}

/**
 *  销毁付款视图
 */
- (void)dismiss
{
    [UIView animateWithDuration:0.25 animations:^{
        self.paymentDetailView.transform = CGAffineTransformTranslate(self.paymentDetailView.transform, 0, kScreenHeight - 250);
        self.paymentPasswordView.transform = CGAffineTransformTranslate(self.paymentPasswordView.transform, 0, kScreenHeight - 250);
    } completion:^(BOOL finished) {
        [self.paymentDetailView removeFromSuperview];
        [self.paymentPasswordView removeFromSuperview];
        [self removeFromSuperview];
        
        self.paymentMethod = 0;
        self.detailInfo = nil;
        self.money = nil;
    }];
}

#pragma mark - WSPaymentDetailViewDelegate
/**
 *  交易详情视图 确认支付
 */
- (void)didTappedConfirmButton:(UIButton *)confrimButton paymentMethod:(WSPaymentMethod)paymentMethod
{
    self.paymentMethod = paymentMethod;
    if (paymentMethod == WSPaymentMethodOnline) {
        // 在线支付直接回调
        [self dismiss];
        if ([self.delegate respondsToSelector:@selector(didTappedConfirmButton:paymentMethod:paymentPassword:)]) {
            [self.delegate didTappedConfirmButton:confrimButton paymentMethod:paymentMethod paymentPassword:nil];
        }
    } else {
        // 余额支付跳转到密码视图
        [UIView animateWithDuration:0.25 animations:^{
            self.paymentDetailView.transform = CGAffineTransformTranslate(self.paymentDetailView.transform, -kScreenWidth, 0);
            self.paymentPasswordView.transform = CGAffineTransformTranslate(self.paymentPasswordView.transform, -kScreenWidth, 0);
        } completion:^(BOOL finished) {
            [self.paymentPasswordView.passwordField becomeFirstResponder];
        }];
    }
}

/**
 *  关闭支付视图
 */
- (void)didTappedcloseButton:(UIButton *)closeButton
{
    [self dismiss];
    if ([self.delegate respondsToSelector:@selector(didTappedColseButton:)]) {
        [self.delegate didTappedColseButton:closeButton];
    }
}

#pragma mark - WSPaymentPasswordViewDelegate
/**
 *  余额支付 确定支付
 */
- (void)didTappedConfirmButton:(UIButton *)confrimButton paymentPassword:(NSString *)paymentPassword
{
    // 来这里肯定是余额支付了
    [self dismiss];
    if ([self.delegate respondsToSelector:@selector(didTappedConfirmButton:paymentMethod:paymentPassword:)]) {
        [self.delegate didTappedConfirmButton:confrimButton paymentMethod:self.paymentMethod paymentPassword:paymentPassword];
    }
}

/**
 *  返回支付详情视图
 */
- (void)didTappedbackButton:(UIButton *)backButton
{
    // 动画偏移视图，显示出支付详情视图
    [UIView animateWithDuration:0.25 animations:^{
        self.paymentDetailView.transform = CGAffineTransformTranslate(self.paymentDetailView.transform, kScreenWidth, 0);
        self.paymentPasswordView.transform = CGAffineTransformTranslate(self.paymentPasswordView.transform, kScreenWidth, 0);
    }];
}

/**
 *  忘记密码
 */
- (void)didTappedForgetPasswordButton:(UIButton *)forgetPasswordButton
{
    [self dismiss];
    if ([self.delegate respondsToSelector:@selector(didTappedForgetPasswordButton:)]) {
        [self.delegate didTappedForgetPasswordButton:forgetPasswordButton];
    }
}

@end

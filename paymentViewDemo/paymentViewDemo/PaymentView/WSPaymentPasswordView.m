//
//  WSPaymentPasswordView.m
//  PayChinaPospIOS
//
//  Created by zhoujianfeng on 16/4/21.
//  Copyright © 2016年 zhoujianfeng. All rights reserved.
//

#import "WSPaymentPasswordView.h"

@interface WSPaymentPasswordView ()
@property (weak, nonatomic) IBOutlet UIView *passwordFieldView;  // 密码背景view
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;


@end

@implementation WSPaymentPasswordView

/**
 *  初始化xib中的控件
 */
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // 密码背景视图
    self.passwordFieldView.layer.borderWidth = 1;
    self.passwordFieldView.layer.borderColor = [UIColor colorWithWhite:0.800 alpha:0.5].CGColor;
    self.passwordFieldView.layer.cornerRadius = 5;
    self.passwordFieldView.layer.masksToBounds = YES;
    
    [self.passwordField addTarget:self action:@selector(didChangePassword:) forControlEvents:UIControlEventEditingChanged];
}

- (void)didChangePassword:(UITextField *)passwordField
{
    if (passwordField.text.length >= 5) {
        self.confirmButton.enabled = YES;
    } else {
        self.confirmButton.enabled = NO;
    }
}

/**
 *  点击了返回
 */
- (IBAction)didTappedBackButton:(UIButton *)button
{
    [self.passwordField resignFirstResponder];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(didTappedPasswordViewBackButton)]) {
            [self.delegate didTappedPasswordViewBackButton];
        }
    });
}

/**
 *  点击了确认
 */
- (IBAction)didTappedConfirmButton:(UIButton *)button
{
    [self.passwordField resignFirstResponder];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(didTappedPasswordViewConfirmButtonWithPaymentPassword:)]) {
            [self.delegate didTappedPasswordViewConfirmButtonWithPaymentPassword:self.passwordField.text];
        }
    });
}

/**
 *  点击了忘记密码
 */
- (IBAction)didTappedForgetButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(didTappedPasswordViewForgetPasswordButton)]) {
        [self.delegate didTappedPasswordViewForgetPasswordButton];
    }
}

@end

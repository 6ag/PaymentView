//
//  WSPaymentDetailView.m
//  PayChinaPospIOS
//
//  Created by zhoujianfeng on 16/4/21.
//  Copyright © 2016年 zhoujianfeng. All rights reserved.
//

#import "WSPaymentDetailView.h"

@implementation WSPaymentDetailView

/**
 *  初始化xib中的控件
 */
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.unityPayButton.layer.borderWidth = 2;
    self.unityPayButton.layer.borderColor = [UIColor colorWithRed:0.227  green:0.533  blue:0.827 alpha:1].CGColor;
    [self.unityPayButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.unityPayButton setTitleColor:[UIColor colorWithRed:0.227  green:0.533  blue:0.827 alpha:1] forState:UIControlStateSelected];
    
    self.balanceButton.layer.borderWidth = 1;
    self.balanceButton.layer.borderColor = [UIColor colorWithWhite:0.800 alpha:0.5].CGColor;
    [self.balanceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.balanceButton setTitleColor:[UIColor colorWithRed:0.227  green:0.533  blue:0.827 alpha:1] forState:UIControlStateSelected];
}

/**
 *  关闭视图
 */
- (IBAction)didTappedCloseButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(didTappedDetailViewCloseButton)]) {
        [self.delegate didTappedDetailViewCloseButton];
    }
}

/**
 *  选择银联支付
 */
- (IBAction)didSelectUnionPayButton:(UIButton *)button
{
    self.balanceButton.selected = NO;
    self.unityPayButton.selected = YES;
    
    self.unityPayButton.layer.borderWidth = 2;
    self.unityPayButton.layer.borderColor = [UIColor colorWithRed:0.227  green:0.533  blue:0.827 alpha:1].CGColor;
    
    self.balanceButton.layer.borderWidth = 1;
    self.balanceButton.layer.borderColor = [UIColor colorWithWhite:0.800 alpha:0.5].CGColor;
}

/**
 *  选择余额支付
 */
- (IBAction)didSelectBalancePayButton:(UIButton *)button
{
    self.unityPayButton.selected = NO;
    self.balanceButton.selected = YES;
    
    self.unityPayButton.layer.borderWidth = 1;
    self.unityPayButton.layer.borderColor = [UIColor colorWithWhite:0.800 alpha:0.5].CGColor;
    
    self.balanceButton.layer.borderWidth = 2;
    self.balanceButton.layer.borderColor = [UIColor colorWithRed:0.227  green:0.533  blue:0.827 alpha:1].CGColor;
}

/**
 *  确认支付
 */
- (IBAction)didTappedConfirmButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(didTappedDetailViewConfirmButtonWithPaymentMethod:)]) {
        [self.delegate didTappedDetailViewConfirmButtonWithPaymentMethod:self.balanceButton.selected];
    }
}

@end

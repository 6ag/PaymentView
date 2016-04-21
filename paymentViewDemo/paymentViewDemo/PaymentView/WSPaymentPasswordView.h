//
//  WSPaymentPasswordView.h
//  PayChinaPospIOS
//
//  Created by zhoujianfeng on 16/4/21.
//  Copyright © 2016年 zhoujianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WSPaymentPasswordView;

@protocol WSPaymentPasswordViewDelegate <NSObject>

- (void)didTappedConfirmButton:(UIButton *)paymentButton paymentPassword:(NSString *)paymentPassword;
- (void)didTappedbackButton:(UIButton *)backButton;
- (void)didTappedForgetPasswordButton:(UIButton *)forgetPasswordButton;

@end

@interface WSPaymentPasswordView : UIView

@property (weak, nonatomic) IBOutlet UITextField *passwordField; // 密码框
@property (nonatomic, weak) id<WSPaymentPasswordViewDelegate> delegate;
@end

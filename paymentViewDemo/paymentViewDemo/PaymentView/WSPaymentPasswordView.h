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

- (void)didTappedPasswordViewConfirmButtonWithPaymentPassword:(NSString *)paymentPassword;
- (void)didTappedPasswordViewBackButton;
- (void)didTappedPasswordViewForgetPasswordButton;

@end

@interface WSPaymentPasswordView : UIView

@property (weak, nonatomic) IBOutlet UITextField *passwordField; // 密码框
@property (nonatomic, weak) id<WSPaymentPasswordViewDelegate> delegate;
@end

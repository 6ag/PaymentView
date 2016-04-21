//
//  WSPaymentView.h
//  PayChinaPospIOS
//
//  Created by zhoujianfeng on 16/4/21.
//  Copyright © 2016年 zhoujianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSPaymentOther.h"
@class WSPaymentView;

@protocol WSPaymentViewDelegate <NSObject>

- (void)didTappedConfirmButton:(UIButton *)paymentButton paymentMethod:(WSPaymentMethod)method paymentPassword:(NSString *)paymentPassword;
- (void)didTappedColseButton:(UIButton *)colseButton;
- (void)didTappedForgetPasswordButton:(UIButton *)forgetPasswordButton;

@end

@interface WSPaymentView : UIView

@property (nonatomic, weak) id<WSPaymentViewDelegate> delegate;

/**
 *  快速创建一个付款视图
 *
 *  @param info          付款详情
 *  @param money         金额
 *  @param paymentMethod 付款方式
 */
- (instancetype)initWithInfo:(NSString *)info money:(NSString *)money paymentMethod:(WSPaymentMethod)paymentMethod;

/**
 *  显示付款视图
 */
- (void)show;

/**
 *  销毁付款视图
 */
- (void)dismiss;

@end

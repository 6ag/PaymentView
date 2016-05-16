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

- (void)didTappedConfirmButtonWithPaymentMethod:(WSPaymentMethod)method paymentPassword:(NSString *)paymentPassword;
- (void)didTappedColseButton;
- (void)didTappedForgetPasswordButton;
- (void)paymentComplete;

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
 *  付款结果
 *
 *  @param result YES为成功
 *  @param message 提示信息
 */
- (void)paymentResult:(BOOL)result message:(NSString *)message;

/**
 *  显示付款视图
 */
- (void)show;

/**
 *  销毁付款视图
 */
- (void)dismiss;

@end

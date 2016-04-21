//
//  WSPaymentOther.h
//  PayChinaPospIOS
//
//  Created by zhoujianfeng on 16/4/21.
//  Copyright © 2016年 zhoujianfeng. All rights reserved.
//

#ifndef WSPaymentOther_h
#define WSPaymentOther_h

typedef enum : NSUInteger {
    WSPaymentMethodOnline =  0,  // 在线付款
    WSPaymentMethodBalance = 1,  // 余额付款
} WSPaymentMethod;

// 屏幕bounds
#define kScreenBounds ([[UIScreen mainScreen] bounds])

// 屏幕尺寸
#define kScreenSize ([[UIScreen mainScreen] bounds].size)

// 屏幕高度
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

// 屏幕宽度
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)

#endif /* WSPaymentOther_h */

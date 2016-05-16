//
//  WSPaymentCircleView.h
//  PayChinaPospIOS
//
//  Created by zhoujianfeng on 16/5/16.
//  Copyright © 2016年 paychina. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    WSLoadStatusLoading,
    WSLoadStatusSuccess,
    WSLoadStatusFailed
} WSLoadStatus;

@interface WSPaymentCircleView : UIView

/**
 *  加载状态
 *
 *  @param status 状态
 */
- (void)loadStatus:(WSLoadStatus)status;

/**
 *  清楚图层
 */
- (void)cleanLayer;

@end

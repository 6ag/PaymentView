//
//  WSPaymentDetailView.h
//  PayChinaPospIOS
//
//  Created by zhoujianfeng on 16/4/21.
//  Copyright © 2016年 zhoujianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSPaymentOther.h"

@protocol  WSPaymentDetailViewDelegate<NSObject>

- (void)didTappedDetailViewConfirmButtonWithPaymentMethod:(WSPaymentMethod)paymentMethod;
- (void)didTappedDetailViewCloseButton;

@end

@interface WSPaymentDetailView : UIView

@property (weak, nonatomic) IBOutlet UIButton *unityPayButton;
@property (weak, nonatomic) IBOutlet UIButton *balanceButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (nonatomic, weak) id<WSPaymentDetailViewDelegate> delegate;

- (IBAction)didSelectUnionPayButton:(UIButton *)button;
- (IBAction)didSelectBalancePayButton:(UIButton *)button;
@end

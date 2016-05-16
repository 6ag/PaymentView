//
//  WSPaymentResultView.m
//  PayChinaPospIOS
//
//  Created by zhoujianfeng on 16/5/16.
//  Copyright © 2016年 paychina. All rights reserved.
//

#import "WSPaymentResultView.h"

@interface WSPaymentResultView ()

@end

@implementation WSPaymentResultView

- (IBAction)didTappedBackButton:(UIButton *)sender
{
    [self.delegate didTappedResultViewBackButton];
}

- (IBAction)didTappedConfimButton:(UIButton *)sender
{
    [self.delegate didTappedResultViewConfirmButton];
}

@end

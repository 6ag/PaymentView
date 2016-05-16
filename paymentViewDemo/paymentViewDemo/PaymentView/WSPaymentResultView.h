//
//  WSPaymentResultView.h
//  PayChinaPospIOS
//
//  Created by zhoujianfeng on 16/5/16.
//  Copyright © 2016年 paychina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSPaymentCircleView.h"

@protocol WSPaymentResultViewDelegate <NSObject>

- (void)didTappedResultViewConfirmButton;
- (void)didTappedResultViewBackButton;

@end

@interface WSPaymentResultView : UIView

@property (nonatomic, weak) id<WSPaymentResultViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet WSPaymentCircleView *loadView;

@end

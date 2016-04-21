//
//  ViewController.m
//  paymentViewDemo
//
//  Created by zhoujianfeng on 16/4/21.
//  Copyright © 2016年 zhoujianfeng. All rights reserved.
//

#import "ViewController.h"
#import "WSPaymentView.h"

@interface ViewController () <WSPaymentViewDelegate>
@property (nonatomic, strong) WSPaymentView *paymentView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTappedPaymentButton:(UIButton *)sender {
    
    // 创建支付视图
    self.paymentView = [[WSPaymentView alloc] initWithInfo:@"订单号: TB54567644556 防压充气娃娃" money:@"1888.00 元" paymentMethod:0];
    self.paymentView.delegate = self;
    [self.paymentView show];
}

#pragma mark - WSPaymentViewDelegate
- (void)didTappedConfirmButton:(UIButton *)paymentButton paymentMethod:(WSPaymentMethod)method paymentPassword:(NSString *)paymentPassword
{
    if (method == WSPaymentMethodOnline) {
        NSLog(@"在线支付");
    } else {
        NSLog(@"余额支付");
    }
}

- (void)didTappedColseButton:(UIButton *)colseButton
{
    NSLog(@"支付视图关闭");
}

- (void)didTappedForgetPasswordButton:(UIButton *)forgetPasswordButton
{
    NSLog(@"忘记密码");
}

@end

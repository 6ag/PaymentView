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
- (void)didTappedConfirmButtonWithPaymentMethod:(WSPaymentMethod)method paymentPassword:(NSString *)paymentPassword
{
    if (method == WSPaymentMethodOnline) {
        NSLog(@"在线支付");
    } else {
        NSLog(@"余额支付 密码: %@", paymentPassword);
        
        // 模拟
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.paymentView paymentResult:YES message:@"付款成功"];
        });
        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.paymentView paymentResult:NO message:@"当前支付密码不正确"];
//        });
        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.paymentView paymentResult:NO message:@"系统异常"];
//        });
        
    }
}

- (void)didTappedColseButton
{
    NSLog(@"支付视图关闭");
}

- (void)didTappedForgetPasswordButton
{
    NSLog(@"忘记密码");
}

- (void)paymentComplete
{
    NSLog(@"付款完成");
}

@end

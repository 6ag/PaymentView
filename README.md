# PaymentView
模仿支付宝输入密码视图demo

![demo图片](https://github.com/6ag/PaymentView/blob/master/paymentViewDemo/1.gif)

## 如何使用
### 导入头文件

```objc
#import "WSPaymentView.h"
```

### 创建并显示视图

```objc
self.paymentView = [[WSPaymentView alloc] initWithInfo:@"订单号: TB54567644556 防压充气娃娃" money:@"1888.00 元" paymentMethod:0];
self.paymentView.delegate = self;
[self.paymentView show];

```

### 遵守协议 **WSPaymentViewDelegate** 并实现代理方法

```objc
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
````

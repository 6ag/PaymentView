# PaymentView
模仿支付宝输入密码视图demo

### 付款成功

![demo图片](https://github.com/6ag/PaymentView/blob/master/paymentViewDemo/1.gif)

### 付款失败
![demo图片](https://github.com/6ag/PaymentView/blob/master/paymentViewDemo/2.gif)

### 密码错误

![demo图片](https://github.com/6ag/PaymentView/blob/master/paymentViewDemo/3.gif)

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
```

### 传递付款结果

上面例子里是模拟的付款结果，真实项目需要在后台返回结果后调用这个接口即可。

```objc
[self.paymentView paymentResult:YES message:@"付款成功"];
```

### 最后

这个demo只是给有需求的朋友一个思路，具体实现可以有很多方式，如果您有更好的方式请不要喷我啊



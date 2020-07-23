//
//  ViewController.m
//  LMUProxyObjTest
//
//  Created by liumu on 2020/7/23.
//  Copyright © 2020 Miul. All rights reserved.
//

#import "ViewController.h"
#import "LMUProxyObj.h"

@interface ViewController ()

@property (nonatomic, strong) NSString *testString;
//@property (nonatomic, strong) LMUProxyObj *proxyString;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.testString = @"测试字符串";
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self startTest];
}

- (void)startTest {
    LMUProxyObj *proxyString = [LMUProxyObj new];
    proxyString.proxyObj = self.testString;
    
    // LMUProxyObj isKindOfClass 返回的结果一定是 LMUProxyObj
    // 只有LMUProxyObj 找不到的方法才会走消息转发
    if ([proxyString isKindOfClass:[NSString class]]) {
        NSLog(@"LMUProxyObj isKindOfClass: YES");
    } else {
        NSLog(@"LMUProxyObj isKindOfClass: NO");
    }
    
    // 会走消息转发
    NSInteger length = (NSInteger)[proxyString performSelector:@selector(length)];
    NSLog(@"字符串长度:%ld", length);
    
    // 同样LMUProxyObj作为NSObject的派生类,已经有-description的默认实现,不会走消息转发逻辑
    NSLog(@"测试字符串:%@", proxyString);
    
    // 会走消息转发,找不到方法的实现会抛异常,crash
    [proxyString performSelector:@selector(test)];
}

@end

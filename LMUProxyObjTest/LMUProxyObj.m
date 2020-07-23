//
//  LMUProxyObj.m
//  LMUProxyObjTest
//
//  Created by liumu on 2020/7/23.
//  Copyright © 2020 Miul. All rights reserved.
//

#import "LMUProxyObj.h"

@implementation LMUProxyObj

// 析构时打印的class 就是LMUProxyObj 本身的class
- (void)dealloc {
    NSLog(@"====>%@ dealloc", NSStringFromClass([self class]));
}

// 快速转发实现
- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([self.proxyObj respondsToSelector:aSelector]) {
        return self.proxyObj;
    }
    return nil;
}

// 快速转发没有实现就会走Invocation转发, Invocation转发内部会调用-methodSignatureForSelector获取方法签名
// 这步如果返回nil,那么- forwardInvocation都不会走到,直接抛异常了
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [self.proxyObj methodSignatureForSelector:aSelector];
    if (signature) {
        return signature;
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL aSelector = anInvocation.selector;
    
    if ([self.proxyObj respondsToSelector:aSelector]) {
        [anInvocation invokeWithTarget:self.proxyObj];
    } else {
        [super forwardInvocation:anInvocation];
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<ProxyObj:%p>", self];
}

@end

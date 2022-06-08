//
//  Foo+Proxy.m
//  OCDemo
//
//  Created by 符传杰 on 2022/6/8.
//

#import "Foo+Proxy.h"
#import "objc/runtime.h"

@implementation Foo(Proxy)

#pragma mark - 1、替换SEL对应的IMP
/**
 - YES: 重试，重试后依然失败则消息转发
 - NO: 消息转发
 */
+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    Method m = class_getInstanceMethod([self class], @selector(dynamicFunc));
//    class_addMethod([self class], sel, method_getImplementation(m), method_getTypeEncoding(m));
    return YES;
}

- (int)dynamicFunc {
    NSLog(@"dynamicFunc");
    return 1;
}

#pragma mark - 2、消息转发:替换消息接受者
/** 重新制定SEL的target
 - id: 让其他对象重试
 - nil: 再次转发
 */
- (id)forwardingTargetForSelector:(SEL)aSelector {
    return nil;
//    return [[OtherFoo alloc] init];
}

#pragma mark - 3、消息转发:变更为任意处理逻辑
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    //查找父类的方法签名
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if(signature == nil) {
        signature = [NSMethodSignature signatureWithObjCTypes:"i@20@0:8i16"];

    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    // 参数：self、SEL、其他
    SEL sel;
    [anInvocation getArgument:&sel atIndex:1];
    // invoke：相当于 forwardTargetForSelector 升级版，甚至可以在方法找不到的时候把输入的参数的信息打印出来
    [anInvocation invokeWithTarget:[[OtherFoo alloc] init]];
    // 最初的函数调用也能拿到这个返回值
    int ret;
    [anInvocation getReturnValue:&ret];
    NSLog(@"选择器:%@ 转发消息返回值%d", [NSString stringWithUTF8String:sel_getName(sel)], ret);
    NSLog(@"消息转发,随便写点东西");
}

@end

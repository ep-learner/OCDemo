//
//  main.m
//  OCDemo
//
//  Created by 符传杰 on 2022/6/8.
//

#import <Foundation/Foundation.h>
#import "Foo+associate.h"
#import "NSTimerDemo.h"
#import "CycleRetainDemo.h"
#import "GCDDemo.h"

#pragma mark - runtime
// 演示方法交换
void testMethodSwap(void) {
    NSLog(@"Foo:");
    Foo *foo = [[Foo alloc] init];
    [foo func1];
    [foo superFunc];
    [Foo staticFunc1];
    NSLog(@"Parent:(父类方法调用不受影响)");
    Parent *parent = [[Parent alloc] init];
    [parent superFunc];
}

// 演示消息转发
void testForwarding(void) {
    Foo *foo = [[Foo alloc] init];
    int a = [foo emptyFunc];
    NSLog(@"%d", a);
}

// 演示关联对象
void testAssociate(void) {
    Foo *foo = [[Foo alloc] init];
    foo.dynamicAddProperty = @"123";
    NSLog(@"%@", foo.dynamicAddProperty);
}

#pragma mark - runloop

#pragma mark - nstimer
void testTimer(void) {
    NSTimerDemo *demo = [[NSTimerDemo alloc] init];
    [[NSRunLoop mainRunLoop] addTimer:demo.timer forMode:NSRunLoopCommonModes];
    [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
}

void testCycle(void) {
    CycleRetainDemo *demo = [[CycleRetainDemo alloc] init];
    [[NSRunLoop mainRunLoop] addTimer:demo.timer forMode:NSRunLoopCommonModes];
    [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
}
#pragma mark - GCD
void testGCDQueueGroup(void) {
    GCDDemo *demo = [[GCDDemo alloc] init];
    [demo simpleDemo];
    [[NSRunLoop mainRunLoop] addPort:[[NSPort alloc] init] forMode:NSRunLoopCommonModes];
    [[NSRunLoop mainRunLoop] run];
//    [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];

//    for (int i = 0; i < 100; i++) {
//        NSLog(@"第 %d 次尝试", i);
//        [demo orderDemo];
//    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        testMethodSwap();
//        testForwarding();
//        testAssociate();
//        testTimer();
//        testCycle();
        testGCDQueueGroup();
    }
    return 0;
}



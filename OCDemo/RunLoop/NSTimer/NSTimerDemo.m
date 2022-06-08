//
//  NSTimerDemo.m
//  demo
//
//  Created by 符传杰 on 2022/6/8.
//

#import "NSTimerDemo.h"
/**
 1、NSProxy
 2、中介者模式，runtime 动态创建一个对象去执行定时器函数【这里直接用block就好】
 */
@implementation NSTimerDemo
- (instancetype)init {
    if (self = [super init]) {
        // 循环引用
        self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(demo) userInfo:nil repeats:YES];
        self.timer = [NSTimer timerWithTimeInterval:1 repeats:NO block:^(NSTimer * _Nonnull timer) {
            NSLog(@"打印");
        }];
    }
    return self;
}

-(void)demo {}

@end

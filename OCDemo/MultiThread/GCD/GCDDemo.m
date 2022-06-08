//
//  GCDDemo.m
//  demo
//
//  Created by 符传杰 on 2022/6/7.
//

#import "GCDDemo.h"


@implementation GCDDemo

/** 创建任务和task
 */
- (void)simpleDemo {
    dispatch_queue_t serial_q = dispatch_queue_create("q1", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(serial_q, ^{
        NSLog(@"runloop %@", [NSRunLoop currentRunLoop]);
        NSLog(@"currentThread %@", [NSThread currentThread]);
        NSLog(@"串行队列");
    });
}

/** queue group
 队列组本质上就是计数[信号量]+异步任务
 - 计数是为了实现：等待前面的任务执行完成这个功能[wait 和 notify]
 - 异步任务不会阻塞创建task的线程【如果想阻塞可以调用wait或者notify进行等待】
 
 输出：
 */
-(void)groupDemo {
    dispatch_queue_t cq = dispatch_queue_create("q1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create(); // 创建队列组
    
    dispatch_group_async(group, cq, ^{
        NSLog(@"task1");
    });
    
    dispatch_group_enter(group);
    dispatch_async(cq, ^{
        NSLog(@"task2");
        dispatch_group_leave(group);
    });
    NSLog(@"task3: 通过group向队列中添加任务不会阻塞创建task的线程");
    
    // 等待group的task执行完成
//    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    // 等待group的task执行完成
    dispatch_group_notify(group, cq, ^{
        NSLog(@"task4");
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 线程间通信属于sources1事件，依赖于RunLoop。
        NSLog(@"%@ %@", [NSThread mainThread], [NSThread currentThread]);
        NSLog(@"主线程RunLoop没有开启时无法执行，这是因为什么？？");
    });
}
-(void)func {
    NSLog(@"runloop %@", [NSRunLoop currentRunLoop]);
    NSLog(@"currentThread %@", [NSThread currentThread]);
}
@end

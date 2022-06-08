//
//  CycleRetainDemo.m
//  demo
//
//  Created by 符传杰 on 2022/6/8.
//

#import "CycleRetainDemo.h"

@implementation CycleRetainDemo

- (instancetype)init {
    if (self = [super init]) {
        self.timer = [NSTimer timerWithTimeInterval:1
                                             target:[[MyProxy alloc] initWithTarget:self]
                                           selector:@selector(demo)
                                           userInfo:nil
                                            repeats:YES];
    }
    return self;
}

-(void)demo {
    NSLog(@"demo");
}
- (void)dealloc {
    NSLog(@"dealloc");
}
@end

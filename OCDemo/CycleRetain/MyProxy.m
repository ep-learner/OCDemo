//
//  MyProxy.m
//  OCDemo
//
//  Created by 符传杰 on 2022/6/8.
//

#import "MyProxy.h"
@implementation MyProxy

- (instancetype)initWithTarget:(id)target {
    self.target = target;
    return self;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self.target;
}

@end

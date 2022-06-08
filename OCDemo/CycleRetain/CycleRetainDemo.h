//
//  CycleRetainDemo.h
//  demo
//
//  Created by 符传杰 on 2022/6/8.
//

#import <Foundation/Foundation.h>
#import "MyProxy.h"
NS_ASSUME_NONNULL_BEGIN

@interface CycleRetainDemo : NSObject
@property(nonatomic, strong) NSTimer *timer;
@end

NS_ASSUME_NONNULL_END

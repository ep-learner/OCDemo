//
//  MyProxy.h
//  OCDemo
//
//  Created by 符传杰 on 2022/6/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyProxy : NSProxy
@property(nonatomic, weak)id target;
- (instancetype)initWithTarget:(id)target;
@end

NS_ASSUME_NONNULL_END

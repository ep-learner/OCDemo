//
//  Foo.h
//  OCDemo
//
//  Created by 符传杰 on 2022/6/8.
//

#import <Foundation/Foundation.h>
#import "Parent.h"
NS_ASSUME_NONNULL_BEGIN

@interface Foo : Parent
- (void)func1;
- (int)emptyFunc;
+ (void)staticFunc1;
@end

NS_ASSUME_NONNULL_END

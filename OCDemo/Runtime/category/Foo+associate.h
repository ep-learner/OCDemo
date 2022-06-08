//
//  Foo+associate.h
//  OCDemo
//
//  Created by 符传杰 on 2022/6/8.
//

#import <Foundation/Foundation.h>
#import "Foo.h"
NS_ASSUME_NONNULL_BEGIN

@interface Foo(associate)
@property (nonatomic, strong) NSString *dynamicAddProperty;
@end

NS_ASSUME_NONNULL_END

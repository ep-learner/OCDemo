//
//  Foo+associate.m
//  OCDemo
//
//  Created by 符传杰 on 2022/6/8.
//

#import "Foo+associate.h"
#import "objc/runtime.h"

@implementation Foo(associate)
#pragma mark - 动态属性关联
// 用于区分不同成员变量，只要不一样就行
static char kDynamicAddProperty;
/**
 getter 方法
 @return 返回关联属性的值
 */
- (NSString *)dynamicAddProperty {
    return objc_getAssociatedObject(self, &kDynamicAddProperty);
}

/**
 setter 方法
 @param dynamicAddProperty 设置关联属性的值
 */
- (void)setDynamicAddProperty:(NSString *)dynamicAddProperty {
    objc_setAssociatedObject(self, &kDynamicAddProperty, dynamicAddProperty, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end

//
//  Foo+swizzle.m
//  OCDemo
//
//  Created by 符传杰 on 2022/6/8.
//

#import "Foo+swizzle.h"
#import "objc/runtime.h"
/**
 一般是给现有类替换方法，所以用类别实现
 1、想要交换类方法需要用 object_getClass 方法
 2、如果不想影响父类参考case2，把方法添加到子类中再交换
 3、实例、类方法交换的逻辑基本相同
 */
@implementation Foo(category)

+ (void)load {
    static dispatch_once_t oncesToken;
    dispatch_once(&oncesToken, ^{
        [Foo swapMethod:@selector(func1) s2:@selector(func2) cls:[self class]];
        [Foo swapMethodWithoutParent:@selector(superFunc) s2:@selector(superFunc2) cls:[self class]];
        [Foo swapStaticMethod:@selector(staticFunc1) s2:@selector(staticFunc2) cls:object_getClass([self class])];
        // 和实例方法一样，如果不想影响父类，还是需要在子类的元类对象中添加方法
//        [Foo swapStaticMethod:@selector(superStaticFunc) s2:@selector(staticFunc2) cls:object_getClass([self class])];
    });
}

// case1:交换实例方法
+ (void)swapMethod:(SEL)s1 s2:(SEL)s2 cls:(Class)cls {
    Method m1 = class_getInstanceMethod(cls, s1);
    Method m2 = class_getInstanceMethod(cls, s2);
    method_exchangeImplementations(m1, m2);
}

// case2:交换实例方法(只希望子类的方法被替换，不影响父类)
+ (void)swapMethodWithoutParent:(SEL)oldSelector s2:(SEL)newSelector cls:(Class)cls {
    Method oldMethod = class_getInstanceMethod(cls, oldSelector); // 可能最终是在父类对象中找到的 Method
    Method newMethod = class_getInstanceMethod(cls, newSelector);

    // 方式1:
    /**
     oldSEL-newIMP添加到子类
     成功：表示oldSEL在父类中找到，修改下newSEL，使其指向old IMP （如果此时交换，相当于oldSEL和newSEL都调用都是newIMP）
     失败：表示oldSEL在子类中找到，直接进行方法交换（因为前面添加没成功，oldSEL依然指向oldIMP）
     */
    BOOL isAddSuccess = class_addMethod(cls, oldSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (isAddSuccess) {
        class_replaceMethod(cls, newSelector, method_getImplementation(oldMethod), method_getTypeEncoding(oldMethod));
    } else {
        method_exchangeImplementations(oldMethod, newMethod);
    }
    // 方式2:需要注意如果oldMethod在父类中，在子类中添加oldSelector 需要重新获取一次oldMethod
//    class_addMethod(cls, oldSelector, method_getImplementation(oldMethod), method_getTypeEncoding(oldMethod));
//    oldMethod = class_getInstanceMethod(cls, oldSelector);
//    method_exchangeImplementations(oldMethod, newMethod);
}

// case3:交换类方法【和实例方法交换基本相同】
+ (void)swapStaticMethod:(SEL)s1 s2:(SEL)s2 cls:(Class)cls {
    Method m1 = class_getClassMethod(cls, s1);
    Method m2 = class_getInstanceMethod(cls, s2);
    method_exchangeImplementations(m1, m2);
}

// 不需要头文件声明，不应该显示调用
- (void)func2 {
    NSLog(@"替换实例方法");
    [self func2];
}

- (void)superFunc2{
    NSLog(@"替换实例方法【因为被替换的类声明在父类中，如果不想影响父类需要在子类中添加一个方法】");
    [self superFunc2];
}

+ (void)staticFunc2 {
    NSLog(@"替换类方法");
    [Foo staticFunc2];
}
@end

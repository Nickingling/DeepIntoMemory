//
//  ArcObject.m
//  DeepInARC
//
//  Created by ronglei on 15/4/28.
//  Copyright (c) 2015年 ronglei. All rights reserved.
//

#import "ArcObject.h"

@implementation ArcObject

- (id)init
{
    self = [super init];
    if (self) {
        // 由于_strongStr被声明为strong(强引用) 它创建了一个所有关系
        // 任何用alloc/init创建的对象在当前范围的生命期内得以保留
        _strongStr = [[NSString alloc] initWithFormat:@"strong string in %@", [self class]];
        
        // 由于_weakStr被声明为weak(弱引用) 它并未创建所有关系
        // 只有当它被其它对象强引用时才有用 __weak变量在摧毁时,被设为nil
        // 下句中字符串对象由于只被_weakStr弱引用着 所以在初始化后立即会被释放 因此编译器会给出警告
        _weakStr = [[NSString alloc] initWithFormat:@"weak string in %@", [self class]];
    }
    return self;
}

- (void)outputString
{
    NSLog(@"\nretain string:%@\nweak string:%@", _strongStr, _weakStr);
}

- (void)weakRefrence
{
    id __weak obj1 = nil;
    {
        id __strong obj0 = [[NSObject alloc] init];
        obj1 = obj0;
        NSLog(@"A: %@", obj1);
    }
    /* 由于obj0已经超出变量的作用于 强引用失效
     * 所以自动释放持有的对象 因对象无持有者 所以废除
     * obj1表示的对象已经被废除 被自动设置为null
     */
    NSLog(@"B: %@", obj1);
    
    id __unsafe_unretained obj2 = nil;
    {
        id __strong obj0 = [[NSObject alloc] init];
        obj2 = obj0;
        NSLog(@"A: %@", obj2);
    }
    /* 由于obj0已经超出变量的作用于 强引用失效
     * 所以自动释放持有的对象 因对象无持有者 所以废除
     * obj2表示的对象已经被废除 变成了野指针
     */
    NSLog(@"B: %@", obj2);
}

- (void)strongRefrence
{
    id __strong obj1 = [[NSArray alloc] init];
    // obj1默认为强引用 自己持有对象
    
    id __strong obj2 = [NSArray array];
    // arc下 由于obj2被__strong修饰 赋值的时候自己持有对象
}

+ (NSArray *)array
{
    NSArray *a = [[NSArray alloc] init];
    
    // 该对象a作为返回值 编译器会自动将其注册到autoreleasepool
    return a;
}

- (void)autoreleaseRefrence
{
    @autoreleasepool {
        id __strong obj = [[NSArray alloc] initWithObjects:@"1", nil];
        
        // 编译器通过判断
        // alloc/new/copy/mutableCopy方法生成的对象
        // 不会被注册到autoreleasepool中
        
        id __weak obj1 = obj;
        
        obj = nil;
        
        // 所以obj被释放一次之后 数组对象被释放
        // weak修饰符修饰的对象obj1被自动设置为null
        NSLog(@"%@\n", obj1);
    }
    
    @autoreleasepool {
        id __strong obj = [NSArray arrayWithObject:@"2"];
        
        // 编译器通过判断
        // 非alloc/new/copy/mutableCopy方法生成的对象
        // 将会自动注册到autoreleasepool中
        
        id __weak obj1 = obj;
        
        obj = nil;
        
        // 所以obj被释放一次之后
        // weak修饰符修饰的对象obj1访问的其实是
        // 上面赋值时就被添加到autoreleasepool中的数组对象
        NSLog(@"%@\n", obj1);
    }
}

@end

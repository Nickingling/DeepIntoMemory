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

@end

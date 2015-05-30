//
//  MrcObject.m
//  DeepInARC
//
//  Created by ronglei on 15/4/28.
//  Copyright (c) 2015年 ronglei. All rights reserved.
//

#import "MrcObject.h"

@implementation MrcObject

- (id)init
{
    self = [super init];
    if (self) {
        _retainStr = [[NSString alloc] initWithFormat:@"retain string in %@", [self class]];
        _assignStr = _retainStr;
    }
    return self;
}

- (void)compareStringAndFormat
{
    // initWithString 与 initWithFormat的比较
    // initWithString的地址在编译的时候就申请好了 它的retainCount为NSIntegerMax 对它进行dealloc会报错 所以他不会被释放 静态对象
    // initWithFormat创建完成后对象的retainCount为1 可以被释放
    
    __weak NSString *normalString = @"create by initWithString";
    __weak NSString *formatString = [[NSString alloc] initWithFormat:@"creat by initWithFormat in %@", [self class]];
    NSLog(@"\ninitWithString string:%@ retainCount:%lu\ninitWithFormat string:%@ retainCount:%lu", normalString, (unsigned long)[normalString retainCount], formatString, (unsigned long)[formatString retainCount]);
}

- (void)outputString
{
    NSLog(@"release before:\nretain string:%@\nassign string:%@", _retainStr, _assignStr);
    
    // 由于_assignStr在赋值的时候不会retain对象 所以[_retainStr release]后 字符串对象的引用计数为0被释放
    // _assignStr不会被自动设为nil 成了野指针
    [_retainStr release];
    NSLog(@"release after:\nretain string:%@\nassign string:%@", _retainStr, _assignStr);
}

- (void)retainRefrence
{
    // alloc/new/copy/mutableCopy生成的对象自己持有
    // 自己持有对象
    id obj1 = [[NSArray alloc] init];
    
    // 类似于下面array方法 返回的对象不被持有
    id obj2 = [NSArray array];
    [obj2 retain];

    // 自己持有对象
    id array1 = [self allocArray];
    
    // 自己不持有对象
    id array2 = [self array];
    // 调用retain 自己持有对象
    [array2 retain];
}

- (NSArray *)allocArray
{
    NSArray *a = [[NSArray alloc] init];
    
    // 取得的对象自己持有对象
    return a;
}

- (NSArray *)array
{
    NSArray *a = [[NSArray alloc] init];
    
    // 取得的对象存在，但自己不持有对象
    // autorelease本质上就是调用NSAutoreleasePool对象的addObject方法
    // 当调用drain时 pool会将array中的对象一次调用release方法
    return [a autorelease];
}

- (void)autoreleaseRefrence
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    id obj = [[NSObject alloc] init];
    [obj autorelease];
    
    [pool drain];
}

- (void)dealloc
{
    [super dealloc];
}
@end

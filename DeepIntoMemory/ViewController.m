//
//  ViewController.m
//  DeepIntoMemory
//
//  Created by ronglei on 15/5/5.
//  Copyright (c) 2015年 ronglei. All rights reserved.
//

#import "ViewController.h"
#import "MrcObject.h"
#import "ArcObject.h"
#import "Helper.h"

@interface ViewController ()
@end

@implementation ViewController

id __weak ref1 = nil;
id __weak ref2 = nil;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 证明__autoreleasing修饰的对象是在当前runloop之后去释放的 下一个runloop中已经被释放
    [self performSelectorOnMainThread:@selector(setObj) withObject:nil waitUntilDone:YES];
#if 1
    // 与 setObj 方法在同一runloop中执行 autorelease对象(obj1,obj2)不会被释放
    [self performSelectorOnMainThread:@selector(printObj) withObject:nil waitUntilDone:YES];
#else
    // 与 setObj 方法在不同一runloop中执行 autorelease对象(obj1,obj2)已经被释放
    [self performSelectorOnMainThread:@selector(printObj) withObject:nil waitUntilDone:NO];
#endif
}

- (void)setObj
{
    __autoreleasing id obj1 = [NSString stringWithFormat:@"%i", 1];
    __autoreleasing id obj2 = [[NSString alloc] initWithFormat:@"%i", 2];
    ref1 = obj1;
    ref2 = obj2;
    NSLog(@"set after\n");
}

- (void)printObj
{
    NSLog(@"\nobj1:%@\nobj2:%@", ref1, ref2);
}

@end

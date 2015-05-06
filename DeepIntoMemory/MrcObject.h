//
//  MrcObject.h
//  DeepInARC
//
//  Created by ronglei on 15/4/28.
//  Copyright (c) 2015年 ronglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MrcObject : NSObject
{
    // 该成员变量不会加入MrcObject实例的Property列表中
    NSString *string;
}
@property (retain, nonatomic) NSString *retainStr;
@property (assign, nonatomic) NSString *assignStr;

- (void)outputString;
- (void)compareStringAndFormat;

@end

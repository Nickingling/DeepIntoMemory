//
//  ArcObject.h
//  DeepInARC
//
//  Created by ronglei on 15/4/28.
//  Copyright (c) 2015年 ronglei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^Block) (void);

@interface ArcObject : NSObject
{
    // 该成员变量不会加入MrcObject实例的Property列表中
    NSString *string;
}
@property (strong, nonatomic) NSString *strongStr;
@property (weak, nonatomic) NSString *weakStr;
@property (copy, nonatomic) Block blk;

// 不加任何属性声明的话会默认设置为
// @property (readwrite, strong, atomic)NSString *noProperty;
@property NSString *noProperty;

- (void)outputString;

@end

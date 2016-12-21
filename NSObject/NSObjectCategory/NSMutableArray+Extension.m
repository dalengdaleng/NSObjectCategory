//
//  NSMutableArray+Extension.m
//  NSObjectCategory
//
//  Created by ios on 16/10/31.
//  Copyright © 2016年 ios. All rights reserved.
//

#import "NSMutableArray+Extension.h"
#import <objc/runtime.h>

@implementation NSMutableArray (Extension)
+ (void)load {
    [self exchangeOriginalMethod:[self methodOfSelector:@selector(addObject:)] withNewMethod:[self methodOfSelector:@selector(avoidCrashAddObject:)]];
    [self exchangeOriginalMethod:[self methodOfSelector:@selector(objectAtIndex:)]  withNewMethod:[self methodOfSelector:@selector(objectAtIndexOrNilM:)]];
    [self exchangeOriginalMethod:[self methodOfSelector:@selector(replaceObjectAtIndex:withObject:)]  withNewMethod:[self methodOfSelector:@selector(safe_replaceObjectAtIndex:withObject:)]];
}

+ (Method)methodOfSelector:(SEL)selector
{
    return class_getInstanceMethod(NSClassFromString(@"__NSArrayM"),selector);
}

+ (void)exchangeOriginalMethod:(Method)originalMethod withNewMethod:(Method)newMethod
{
    method_exchangeImplementations(originalMethod, newMethod);
}

- (void)avoidCrashAddObject:(id)anObject {
    @try {
        //其实就是调用addObject
        [self avoidCrashAddObject:anObject];
    } @catch (NSException *exception) {
        //能来到这里,说明可变数组添加元素的代码有问题
        //你可以在这里进行相应的操作处理
        NSLog(@"异常名称:%@ 异常原因:%@",exception.name, exception.reason);
    } @finally {
            //在这里的代码一定会执行，你也可以进行相应的操作
    }
}

- (id)objectAtIndexOrNilM:(NSUInteger)index
{
    return (index < [self count]) ? [self objectAtIndexOrNilM:index] : nil;
}

- (void)safe_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if ((index < [self count]) && anObject) {
        [self safe_replaceObjectAtIndex:index withObject:anObject];
    }
}
@end

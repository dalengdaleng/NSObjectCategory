//
//  NSObject+Extension.m
//  NSObjectCategory
//
//  Created by ios on 16/10/31.
//  Copyright © 2016年 ios. All rights reserved.
//

#import "NSObject+Extension.h"
#import <objc/runtime.h>

@implementation NSObject (Extension)
+ (void)load {
    [self exchangeOriginalMethod:[self methodOfSelector:@selector(isKindOfClass:)]  withNewMethod:[self methodOfSelector:@selector(safe_isKindOfClass:)]];
}

+ (Method)methodOfSelector:(SEL)selector
{
    return class_getInstanceMethod(NSClassFromString(@"__NSArrayM"),selector);
}

+ (void)exchangeOriginalMethod:(Method)originalMethod withNewMethod:(Method)newMethod
{
    method_exchangeImplementations(originalMethod, newMethod);
}

- (BOOL)safe_isKindOfClass:(Class)aClass
{
    
    return YES;
}
@end

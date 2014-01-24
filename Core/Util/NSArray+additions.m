//
//  NSArray+additions.m
//  DVTest
//
//  Created by psy on 14-1-24.
//  Copyright (c) 2014年 psy. All rights reserved.
//

#import "NSArray+additions.h"

@implementation NSArray (additions)

@end

@implementation NSArray (ListOperation)

- (NSArray *)mapCar:(id (^)(id, NSUInteger, BOOL *))block
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    for (NSUInteger index = 0;index < self.count;index++) {
        id object = [self objectAtIndex:index];
        BOOL stop = NO;
        id result = block(object, index, &stop);
        if (result) {
            [array addObject:result];
        }
        if (stop) {
            break;
        }
    }
    return [NSArray arrayWithArray:array];
}

@end
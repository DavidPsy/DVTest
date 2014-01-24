//
//  NSArray+additions.h
//  DVTest
//
//  Created by psy on 14-1-24.
//  Copyright (c) 2014年 psy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (additions)

@end

@interface NSArray (ListOperation)

- (NSArray *)mapCar:(id (^)(id obj, NSUInteger idx, BOOL *stop))block;

@end

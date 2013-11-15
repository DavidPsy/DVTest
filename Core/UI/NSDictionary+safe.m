//
//  NSDictionary+safe.m
//  DVTest
//
//  Created by psy on 13-10-14.
//  Copyright (c) 2013年 psy. All rights reserved.
//

#import "NSDictionary+safe.h"

@implementation NSDictionary (safe)

- (void)setSafeValue:(id)value forKey:(NSString*)key {
    if (value && key) {
        [self setValue:value forKey:key];
    }
}

@end

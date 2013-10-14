//
//  NSDictionary+safe.h
//  DVTest
//
//  Created by psy on 13-10-14.
//  Copyright (c) 2013年 psy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (safe)

- (void)setSafeValue:(id)value forKey:(NSString*)key;

@end

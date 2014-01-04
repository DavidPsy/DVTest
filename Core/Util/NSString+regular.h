//
//  NSString+regular.h
//  DVTest
//
//  Created by pan Shiyu on 14-1-4.
//  Copyright (c) 2014年 psy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (regular)

-(BOOL)isEmptyOrNull;

-(BOOL)isNumberOnly;

-(BOOL)isLetterOnly;

-(BOOL)isNumberAndLetter;

-(BOOL)isEmail;

-(BOOL)matchWithReg:(NSString *)reg;

@end

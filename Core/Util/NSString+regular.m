//
//  NSString+regular.m
//  DVTest
//
//  Created by pan Shiyu on 14-1-4.
//  Copyright (c) 2014年 psy. All rights reserved.
//

#import "NSString+regular.h"

#define EMPTY @""
#define EMAIL_REGEX @"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$"
#define NUMBER_REGEX @"^[0-9]*[1-9][0-9]*$"
#define LETTER_REGEX @"^[A-Za-z]+$"
#define NUMBER_AND_LETTER_REGEX @"^\\w+$"
#define STRING_SEED @"QWERTYUIOPLKJHGFDSAZXCVBNMzxcvbnmlkjhgfdsaqwertyuiop1234567890"

@implementation NSString (regular)

-(BOOL)isEmptyOrNull{
    return self==nil?YES:([self isEqualToString:EMPTY]?YES:NO);
}

-(BOOL)isNumberOnly{
    return [self matchWithReg:NUMBER_REGEX];
}

-(BOOL)isLetterOnly{
    return [self matchWithReg:LETTER_REGEX];
}

-(BOOL)isNumberAndLetter{
    return [self matchWithReg:NUMBER_AND_LETTER_REGEX];
}

-(BOOL)isEmail{
    return [self matchWithReg:EMAIL_REGEX];
}

-(BOOL)matchWithReg:(NSString *)reg{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:reg options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger test = [regex numberOfMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, [self length])];
    return test==0?YES:NO;
}

//+(BOOL)isNumber:(int)i GreaterThanNumber:(int)max{
//    
//    return i>max?YES:NO;
//    
//}
//+(BOOL)isNumber:(int)i LessThanNumber:(int)min{
//    
//    return i<min?YES:NO;
//    
//}
//+(BOOL)isNumber:(int)i GreaterThanNumber:(int)max orLessThanNumber:(int)min{
//    
//    return (([self isNumber:i GreaterThanNumber:max])|([self isNumber:i LessThanNumber:min]));
//    
//}
//+(NSString *)encodeString:(NSString *)input{
//    
//    NSString *output = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)input, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
//    return output;
//    
//}
//
//+(NSString *)decodeString:(NSString *)input{
//    NSMutableString *output = [NSMutableString stringWithString:input];
//    [output replaceOccurrencesOfString:@"+" withString:@" " options:NSLiteralSearch range:NSMakeRange(0, [output length])];
//    return [output stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    
//}

//+(int)randomNumber:(int)from to:(int)to {
//    
//    return (int)(from + arc4random() % (to-from+1));
//}
//
//+(NSString *)randomString:(int)num{
//    
//    NSMutableString *s = [[NSMutableString alloc] initWithCapacity:16];
//    
//    NSString *seed = STRING_SEED;
//    
//    for (int i=0; i<num ; i++) {
//        
//        [s appendFormat:@"%c",[seed characterAtIndex:[self randomNumber:0 to:([seed length]-1)]]];
//        
//    }
//    return s;
//}

@end


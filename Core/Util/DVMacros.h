//
//  DVMacros.h
//  DVTest
//
//  Created by pan Shiyu on 13-12-27.
//  Copyright (c) 2013年 psy. All rights reserved.
//

#import "TKAlertCenter.h"

#define DVAlert(s) [[TKAlertCenter defaultCenter] postAlertWithMessage:s];
#define DVAlertNeedClick(s) UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:s delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];[alert show];
#define DVAlertDetail(t,d) UIAlertView *alert = [[UIAlertView alloc] initWithTitle:t message:d delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];[alert show];

#define DVColorClear [UIColor clearColor]
#define DVColorBlue [UIColor blueColor]
#define DVColorRed [UIColor redColor]

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define RGBSAME(a) [UIColor colorWithRed:(a)/255.0f green:(a)/255.0f blue:(a)/255.0f alpha:1]

#define Font(x) [UIFont systemFontOfSize:x]
#define BoldFont(x) [UIFont boldSystemFontOfSize:x]

#define HEXCOLOR(hexValue) [UIColor colorWithRed:((CGFloat)((hexValue & 0xFF0000) >> 16))/255.0 green:((CGFloat)((hexValue & 0xFF00) >> 8))/255.0 blue:((CGFloat)(hexValue & 0xFF))/255.0 alpha:1.0]

#define HEXACOLOR(hexValue, alphaValue) [UIColor colorWithRed:((CGFloat)((hexValue & 0xFF0000) >> 16))/255.0 green:((CGFloat)((hexValue & 0xFF00) >> 8))/255.0 blue:((CGFloat)(hexValue & 0xFF))/255.0 alpha:(alphaValue)]

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#ifdef DEBUG
#define DVLog(s,...) NSLog(@"<%@(%d)> %@",[[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])
#else
#define DVLog(s,...)
#endif



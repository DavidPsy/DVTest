//
//  DVTools.h
//  DVTest
//
//  Created by psy on 13-10-14.
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

#define Font(x) [UIFont systemFontOfSize:x]
#define BoldFont(x) [UIFont boldSystemFontOfSize:x]
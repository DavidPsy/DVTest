//
//  DVTools.h
//  DVTest
//
//  Created by psy on 13-10-14.
//  Copyright (c) 2013年 psy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKAlertCenter.h"

@interface DVTools : NSObject

@end

#define DVAlert(s) [[TKAlertCenter defaultCenter] postAlertWithMessage:s];
#define DVAlertNeedClick(s) UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:s delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];[alert show];
#define DVAlertDetail(t,d) UIAlertView *alert = [[UIAlertView alloc] initWithTitle:t message:d delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];[alert show];

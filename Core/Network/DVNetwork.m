//
//  DVNetwork.m
//  DVTest
//
//  Created by pan Shiyu on 13-10-17.
//  Copyright (c) 2013年 psy. All rights reserved.
//

#import "DVNetwork.h"

//static NSString * const AFAppDotNetAPIBaseURLString = @"https://http://111.199.207.198:9080/bird/plaza/";
static NSString * const AFAppDotNetAPIBaseURLString = @"http://api.mobile.meituan.com/group/v1/";
//http://api.mobile.meituan.com/group/v1/area/list?cityId=1
@implementation DVNetwork

+ (instancetype)netClient {
    static DVNetwork *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[DVNetwork alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
        [_sharedClient setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];
    });
    
    return _sharedClient;
}

@end

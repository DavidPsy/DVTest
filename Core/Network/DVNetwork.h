//
//  DVNetwork.h
//  DVTest
//
//  Created by pan Shiyu on 13-10-17.
//  Copyright (c) 2013年 psy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface DVNetwork : AFHTTPSessionManager

+ (instancetype)netClient;

//+ (void)getPath:(NSString *)path
//     parameters:(NSDictionary *)parameters
//        success:(void (^)(NSDictionary *result, NSData *responseObject))success
//        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
//
//+ (void)postPath:(NSString *)path
//      parameters:(NSDictionary *)parameters
//         success:(void (^)(NSDictionary *result))success
//         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end

//
//  DataCenter.h
//  DVTest
//
//  Created by psy on 13-10-8.
//  Copyright (c) 2013年 psy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DVRequest;
@interface DataCenter : NSObject
@property (nonatomic,strong)NSMutableArray *requestList;

+(DataCenter*)sharedDataCenter;

- (void)appendRequest:(DVRequest*)tmpRequest;

@end

#pragma mark - 数据单元

@protocol DVDataBaseProtocol <NSObject>

- (id)initWithDict:(NSDictionary*)cacheDict;
- (NSDictionary*)convertToDict;

@end

@interface DVRequest : NSObject<DVDataBaseProtocol>

@property (nonatomic,strong)NSString *baseURL;
@property (nonatomic,strong)NSMutableDictionary *paramsMap;
@property (nonatomic,strong)NSString *tag;
- (void)run:(void (^)(NSDictionary* result,NSError *error)) finished;

- (id)initWithURL:(NSString*)baseURL paramsList:(NSArray*)paramsList tag:(NSString*)tag;

- (NSMutableArray*)paramsArray;

- (id)initWithDict:(NSDictionary*)cacheDict;
- (NSDictionary*)convertToDict;

@end


@interface DVParam : NSObject
@property (nonatomic,strong)NSString *key;
@property (nonatomic,strong)NSString *value;
@end



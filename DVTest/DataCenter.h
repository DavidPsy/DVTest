//
//  DataCenter.h
//  DVTest
//
//  Created by psy on 13-10-8.
//  Copyright (c) 2013年 psy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DVOpenAppUnit;
@interface DataCenter : NSObject
@property (nonatomic,strong)NSMutableArray *requestList;
@property (nonatomic,strong)NSMutableArray *openAppList;

+(DataCenter*)sharedDataCenter;


- (void)appendPush:(DVOpenAppUnit*)tmpPushUnit;

@end


#pragma mark - 数据单元


@protocol DVDataBaseProtocol <NSObject>

- (id)initWithDict:(NSDictionary*)cacheDict;
- (NSDictionary*)convertToDict;

@end


@interface DVRequest : NSObject

@property (nonatomic,strong)NSString *baseURL;
@property (nonatomic,strong)NSMutableDictionary *paramsMap;

@property (nonatomic,strong)NSString *tag;

- (id)initWithURL:(NSString*)baseURL paramsList:(NSArray*)paramsList;

- (NSMutableArray*)paramsArray;


@end


@interface DVParam : NSObject

@property (nonatomic,strong)NSString *key;
@property (nonatomic,strong)NSString *value;

@end


@interface DVOpenAppUnit : NSObject<DVDataBaseProtocol>

@property (nonatomic,copy)NSString *schema;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)NSString *tag;

- (id)initWithSchema:(NSString*)schema content:(NSString*)content tag:(NSString*)tag;


@end


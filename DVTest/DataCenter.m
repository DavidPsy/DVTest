//
//  DataCenter.m
//  DVTest
//
//  Created by psy on 13-10-8.
//  Copyright (c) 2013年 psy. All rights reserved.
//

#import "DataCenter.h"
#import "NSDictionary+safe.h"

#import <AFNetworking.h>

#define kPathRequest @"kPathRequest"
#define kPathPush @"kPathPush"

@implementation DataCenter

+(DataCenter*)sharedDataCenter {
    static DataCenter *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DataCenter alloc] init];
    });
    return instance;
}

- (id) init{
    self = [super init];
    if (self) {
        _requestList = [NSMutableArray array];
        _openAppList = [NSMutableArray array];
        
        //read from cache
        NSArray *pushArray = [[NSUserDefaults standardUserDefaults]objectForKey:kPathPush];
        for (NSDictionary *tmpDict in pushArray) {
            DVOpenAppUnit *tmpPushUnit = [[DVOpenAppUnit alloc] initWithDict:tmpDict];
            if (tmpPushUnit) {
                [_openAppList addObject:tmpPushUnit];
            }
        }
        
        NSArray *requestsArray = [[NSUserDefaults standardUserDefaults]objectForKey:kPathRequest];
        for (NSDictionary *tmpDict in requestsArray) {
            DVRequest *tmpRequest = [[DVRequest alloc] initWithDict:tmpDict];
            if (tmpRequest) {
                [_requestList addObject:tmpRequest];
            }
        }
        
    }
    return self;
}

- (void)appendPush:(DVOpenAppUnit*)tmpPushUnit {
    [_openAppList addObject:tmpPushUnit];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *copyArray = [NSArray arrayWithArray:_openAppList];
        
        NSMutableArray *saveArray = [NSMutableArray array];
        for (id<DVDataBaseProtocol> tmpData in copyArray) {
            NSDictionary *dict = [tmpData convertToDict];
            [saveArray addObject:dict];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:saveArray forKey:kPathPush];
        [[NSUserDefaults standardUserDefaults] synchronize];
    });
    
}

- (void)appendRequest:(DVRequest*)tmpRequest {
    [_requestList addObject:tmpRequest];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *copyArray = [NSArray arrayWithArray:_requestList];
        
        NSMutableArray *saveArray = [NSMutableArray array];
        for (id<DVDataBaseProtocol> tmpData in copyArray) {
            NSDictionary *dict = [tmpData convertToDict];
            [saveArray addObject:dict];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:saveArray forKey:kPathRequest];
        [[NSUserDefaults standardUserDefaults] synchronize];
    });
}

@end


@implementation DVRequest

- (id)initWithURL:(NSString*)baseURL paramsList:(NSArray*)paramsList tag:(NSString*)tag{
    if (!baseURL || !paramsList || paramsList.count==0 || tag.length < 1) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _baseURL = baseURL;
        _paramsMap = [NSMutableDictionary dictionary];
        for (DVParam *tmpParam in paramsList) {
            if (tmpParam.value && tmpParam.key) {
                [_paramsMap setValue:tmpParam.value forKey:tmpParam.key];
            }
        }
        _tag = tag;
    }
    return self;
}

- (NSMutableArray*)paramsArray {
    NSMutableArray *paramsArray = [NSMutableArray array];
    NSArray *keys = [_paramsMap allKeys];
    for (NSString *key in keys) {
        DVParam *tmpParam = [[DVParam alloc] init];
        tmpParam.key = key;
        tmpParam.value = _paramsMap[key];
        [paramsArray addObject:tmpParam];
    }
    return paramsArray;
}

- (id)initWithDict:(NSDictionary*)cacheDict {
    if (!cacheDict) {
        return nil;
    }
    
    NSString *baseURL = cacheDict[@"baseURL"];
    NSDictionary *paramsDict = cacheDict[@"paramsMap"];
    NSString *tag = cacheDict[@"tag"];
    
    
    if (!baseURL || !paramsDict || tag.length < 1) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _baseURL = baseURL;
        _paramsMap = [NSMutableDictionary dictionaryWithDictionary:paramsDict];
        _tag = tag;
    }
    return self;
}
- (NSDictionary*)convertToDict {
    NSMutableDictionary *tmpDict = [NSMutableDictionary dictionary];
    [tmpDict setSafeValue:_baseURL forKey:@"baseURL"];
    [tmpDict setSafeValue:_paramsMap forKey:@"paramsMap"];
    [tmpDict setSafeValue:_tag forKey:@"tag"];
    return tmpDict;
}

- (void)run:(void (^)(NSString* result)) finished {
//    http://music.baidu.com/search?key={query}
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/html"];
//    op.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:@"http://music.baidu.com/search" parameters:[NSDictionary dictionaryWithObject:@"hi" forKey:@"key"] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSError *error = nil;
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
        
        NSLog([responseDictionary description]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog([error description]);
    }];
    


}

@end

@implementation DVParam


@end

@implementation DVOpenAppUnit

- (id)initWithSchema:(NSString*)schema content:(NSString*)content tag:(NSString*)tag {
    if (schema.length > 1 && content.length > 1 && tag.length > 1) {
        self = [super init];
        if (self) {
            _schema = schema;
            _content = content;
            _tag = tag;
        }
        return self;
    }
    
    return nil;
}

- (id)initWithDict:(NSDictionary*)cacheDict {
    if (!cacheDict) {
        return nil;
    }
    return [self initWithSchema:cacheDict[@"schema"] content:cacheDict[@"content"] tag:cacheDict[@"tag"]];
}

- (NSDictionary*)convertToDict {
    NSMutableDictionary *tmpDict = [NSMutableDictionary dictionary];
    [tmpDict setSafeValue:_schema forKey:@"schema"];
    [tmpDict setSafeValue:_content forKey:@"content"];
    [tmpDict setSafeValue:_tag forKey:@"tag"];
    return tmpDict;
}

@end

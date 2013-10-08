//
//  DataCenter.h
//  DVTest
//
//  Created by psy on 13-10-8.
//  Copyright (c) 2013年 psy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataCenter : NSObject
@property (nonatomic,strong)NSMutableArray *requestList;

+(DataCenter*)sharedDataCenter;

@end


#pragma mark - 数据单元

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


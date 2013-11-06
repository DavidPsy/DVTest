//
//  Snake.m
//  DVTest
//
//  Created by psy on 13-9-25.
//  Copyright (c) 2013年 psy. All rights reserved.
//

#import "Snake.h"

@implementation Snake

- (void) initData {
    _names = [NSMutableArray arrayWithObjects:@"zhangsan",@"lisi", nil];
}

- (void)dealloc {
    self.names = nil;
}

@end


@implementation LittleSnake

- (void)dealloc {
    self.names = nil;
}

@end
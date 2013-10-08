//
//  Snake.h
//  DVTest
//
//  Created by psy on 13-9-25.
//  Copyright (c) 2013年 psy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Snake : NSObject

@property (nonatomic,strong)NSMutableArray *names;

- (void)initData;

@end


#pragma mark - 

@interface LittleSnake : Snake

@end

//
//  DVRequestDetailsVC.h
//  DVTest
//
//  Created by pan Shiyu on 14-1-5.
//  Copyright (c) 2014年 psy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DVRequest;

@interface DVReqDetailsVC : UIViewController<UIPageViewControllerDelegate, UIPageViewControllerDataSource>
@property (nonatomic,strong)DVRequest *outRequest;
@end

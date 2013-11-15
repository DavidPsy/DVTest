//
//  DVLocationManager.h
//  DVUs
//
//  Created by pan Shiyu on 13-11-15.
//  Copyright (c) 2013年 pan Shiyu. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

/**
 设计思路，做三件事
 1，去定位
 2，存最近一次成功的定位信息
 undo now//3，定位返回的数据做本地变换
 
 info
 1，信息传输方式，用通知
 2,apple 定位出来的信息，是gps坐标,是正确的
    但是直接放在地图上会有问题，因为地图是天朝的，做了一定的加密
 3，那么这个算法处理就好就叫做火星坐标就好
 
 */

extern NSString *const kLocationUpdatedNotification;
extern NSString *const kLocationErrorDomain;

typedef enum {
    DVLocatResultSucess = 0,
    DVLocatResultFail,
    DVLocatResultNotEnable,
    DVLocatResultUnknow,
}DVLocatResult;

//有效期10分钟，这里我们假设10分钟人走不远
#define kLocationExpiredTime 60*10

@interface DVLocationCenter : CLLocationManager<CLLocationManagerDelegate>

+ (DVLocationCenter*)sharedLocationCenter;

//上一次定位的位置
- (CLLocation*)lastLocation;

- (CLLocation*)lastMarsLocation;

//开始定位
- (void)startLocating;

@end




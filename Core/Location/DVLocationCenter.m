//
//  DVLocationManager.m
//  DVUs
//
//  Created by pan Shiyu on 13-11-15.
//  Copyright (c) 2013年 pan Shiyu. All rights reserved.
//

#import "DVLocationCenter.h"
#import "WGS2Mars.h"

NSString *const kLocationUpdatedNotification = @"kLocationUpdatedNotification";
NSString *const kLocationErrorDomain = @"kLocationErrorDomain";

@interface DVLocationCenter ()
@property (nonatomic,assign,readonly)BOOL isLocating;
@property (nonatomic,assign)BOOL canLocate;

@property (nonatomic,strong)CLLocation *lastLocation;
@property (nonatomic,strong)CLLocation *lastMarsLocation;
@property (nonatomic,strong)NSDate *lastDate;
@end

@implementation DVLocationCenter {
    BOOL _isLocating;
}

+ (DVLocationCenter*)sharedLocationCenter {
    static DVLocationCenter *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DVLocationCenter alloc] init];
    });
    return instance;
}

- (CLLocation*)lastLocation {
    if (_lastDate && _lastLocation && [_lastDate timeIntervalSinceNow] < -kLocationExpiredTime) {
        return _lastLocation;
    }
    return nil;
}

- (CLLocation*)lastMarsLocation {
    if (self.lastLocation && _lastMarsLocation) {
        return _lastMarsLocation;
    }
    return nil;
}

- (void)startLocating {
    if (self.isLocating) {
        //不用处理，完毕后会发通知
        return;
    }
    
    if (!self.canLocate) {
        //post 一个不能用的通知
        NSError *error = [NSError errorWithDomain:kLocationErrorDomain
                                             code:DVLocatResultNotEnable
                                         userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:kLocationUpdatedNotification object:error];
        return;
    }
    
    [self startUpdatingLocation];
}

- (CLLocation*)marsLocFromGPSLoc:(CLLocation*)gpsLocation {
    double lat = 0;
    double lng = 0;
    
    transform(gpsLocation.coordinate.latitude, gpsLocation.coordinate.longitude, &lat, &lng);
    
    return [[CLLocation alloc] initWithLatitude:lat longitude:lng];
}

#pragma mark - degate

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation {
    if (!self.isLocating) {
        //线程是否存在不安全的可能？
        return;
    }
    
    _lastDate = [NSDate date];
    _lastLocation = newLocation;
    _lastMarsLocation = [self marsLocFromGPSLoc:_lastLocation];
    
    self.isLocating = NO;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kLocationUpdatedNotification object:_lastLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager
rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region
              withError:(NSError *)error {
    if (self.isLocating) {
        self.isLocating = NO;
        [self stopUpdatingLocation];
        [[NSNotificationCenter defaultCenter] postNotificationName:kLocationUpdatedNotification object:error];
    }
}

#pragma mark -

- (BOOL)canLocate {
    return (([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized) ||
            ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined))
    && [CLLocationManager locationServicesEnabled];
}

- (BOOL)isLocating {
    @synchronized(self){
        return _isLocating;
    }
}

- (void)setIsLocating:(BOOL)isLocating {
    @synchronized(self){
        _isLocating = isLocating;
    }
}

@end

//
//  ZWZMapVC2.m
//  gannicus
//
//  Created by pan Shiyu on 13-11-11.
//  Copyright (c) 2013年 bbk. All rights reserved.
//

#import "ZWZMapVC2.h"

#define kDefaultDelta 0.02

@interface ZWZMapVC2 ()

@property (nonatomic,strong)MKMapView *mapView;
@property (nonatomic,strong)NSMutableArray *annotations;
- (void)removeAllAnnotions;
@end

@implementation ZWZMapVC2 {
    MKCoordinateRegion _currentRegion;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self initNavigationAndButtons];
}

- (void)loadView {
    self.view = self.mapView;
}

- (void)removeAllAnnotions {
    [_mapView removeAnnotations:self.annotations];
    [_annotations removeAllObjects];
}

- (void)updateDisplayWithUsers:(NSArray*)users {
    //这里已经获取到了所有user的信息，可以重新计算并做reset mapregion操作了
//    [self autoScaleMapWithCenter:userMapView.centerCoordinate];
    
    //由于只做add操作，所以 removeAllAnnotions 用不上
    NSMutableArray *newUsers = [NSMutableArray arrayWithCapacity:users.count];
    for (ZWZPerson *person in users) {
        UserAnnotation *annotation = [UserAnnotation UserAnnotationWithPersion:person];
        [newUsers addObject:annotation];
    }
    [_mapView addAnnotations:newUsers];
}

- (void)reloadData {
    [[ZWZMapStore instance] aroundUserWithLatitude:_currentRegion.center.latitude
                                    withLongtitude:_currentRegion.center.longitude
                                           success:^(NSArray *users) {
                                               [self updateDisplayWithUsers:users];
                                           }
                                           failure:^(NSError *error) { }];
}

#pragma mark - map delegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    MKAnnotationView *userLocationView = [mapView viewForAnnotation:userLocation];
    userLocationView.canShowCallout = NO;
    
    float latitudeDelta = mapView.region.span.latitudeDelta<kDefaultDelta ? mapView.region.span.latitudeDelta : kDefaultDelta;
    float longitudeDelta = mapView.region.span.longitudeDelta<kDefaultDelta ? mapView.region.span.longitudeDelta : kDefaultDelta;
    MKCoordinateRegion newRegion = MKCoordinateRegionMake(userLocation.location.coordinate, MKCoordinateSpanMake(latitudeDelta , longitudeDelta));
    [mapView setRegion:newRegion animated:YES];
    
}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error {
    
    if (error.code == 1) {
        // should alert 开启定位
    }
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    static NSString *identifier = @"UserAnnotationView";
    
    MKAnnotationView *view = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!view) {
        view = [[UserAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:identifier];
    }
    
    view.annotation = annotation;
    return view;
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    // if mapview.region ！= _curRegion
    // here can put the gesture logic as follows
    //    if (mapView.region.span.latitudeDelta > _currentRegion.span.latitudeDelta) {
    //        
    //    }
    _currentRegion = mapView.region;
    [self reloadData];
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    /**这里给新加的做动画
    需求是 第一次打开或者点击定位按钮，头像从天下掉下来,那这里加逻辑判断即可
    example as follows
     */
    
    for (UIView *view in views) {
        if (![view isKindOfClass:[UserAnnotationView class]]) {
            continue;
        }
        
        CGPoint aimCenter = view.center;
        view.center = CGPointMake(aimCenter.x, -50);//放到屏幕上方
        
        [UIView animateWithDuration:0.3 animations:^{
            view.center = aimCenter;
        }];
    }
    
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(UserAnnotationView *)view {
    if (![view isKindOfClass:[UserAnnotationView class]]) {
        return;
    }
    
    UserAnnotation *curActiveAnn = view.annotation;
    // OK,go details page now
}

#pragma mark - methods

- (void)startUserLocateHandler {
    //定位到当前位置？那下面的代码可好？
    //如果有userLocation，直接根据当前位置set一个mapRegion
    //否则，走地图的showUserLocation方法
    
    if (_mapView.showsUserLocation && (_mapView.userLocation.location.coordinate.latitude != 0 && _mapView.userLocation.location.coordinate.longitude != 0)) {
        float latitudeDelta = _mapView.region.span.latitudeDelta<kDefaultDelta ? _mapView.region.span.latitudeDelta : kDefaultDelta;
        float longitudeDelta = _mapView.region.span.longitudeDelta<kDefaultDelta ? _mapView.region.span.longitudeDelta : kDefaultDelta;
        MKCoordinateRegion newRegion = MKCoordinateRegionMake(_mapView.userLocation.location.coordinate, MKCoordinateSpanMake(latitudeDelta , longitudeDelta));
        [_mapView setRegion:newRegion animated:YES];
        
    }else {
        _mapView.showsUserLocation = YES;
    }
}

- (void)clickShowLocationList {
    // nothing but show a list
}

#pragma mark - init

- (void)initNavigationAndButtons
{
    UIButton *mapLocationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    mapLocationButton.backgroundColor = [UIColor clearColor];
    mapLocationButton.tintColor = [UIColor clearColor];
    [mapLocationButton setImage:[UIImage imageNamed:@"locationButton"] forState:UIControlStateNormal];
    [mapLocationButton setBackgroundImage:[[UIImage imageNamed:@"mapButtonbg"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    mapLocationButton.layer.shadowColor = [UIColor blackColor].CGColor;
    mapLocationButton.layer.shadowOffset = CGSizeMake(1, 1);
    mapLocationButton.layer.shadowOpacity = 0.2;
    mapLocationButton.layer.shadowRadius = 0.5;
    [mapLocationButton addTarget:self action:@selector(startUserLocateHandler) forControlEvents:UIControlEventTouchUpInside];
    mapLocationButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIBarButtonItem *mapListButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav-button-icon-friends"] style:UIBarButtonItemStylePlain target:self action:@selector(clickShowLocationList)];
    self.navigationItem.rightBarButtonItem = mapListButton;
    
    NSDictionary *views = @{@"root": self.view, @"locate": mapLocationButton};
    [self.view addSubview:mapLocationButton];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[locate(34)]-8-|"
                                                                      options:0 metrics:nil views:views ]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[locate(34)]"
                                                                      options:0 metrics:nil views:views ]];
}


#pragma mark - 

- (NSMutableArray*)annotations {
    if (!_annotations) {
        _annotations = [NSMutableArray array];
    }
    return _annotations;
}

- (MKMapView*)mapView {
    if (!_mapView) {
        _mapView = [[MKMapView alloc] init];
        _mapView.delegate = self;
        _mapView.mapType = MKMapTypeStandard;
    }
    return _mapView;
}

@end

@implementation UserAnnotation

+ (UserAnnotation*)UserAnnotationWithPersion:(ZWZPerson*)persion {
    UserAnnotation *ann = [[UserAnnotation alloc] init];
    [ann setCoordinate:CLLocationCoordinate2DMake(persion.latitude, persion.longitude)];
    ann.persion = persion;
    return ann;
}

@end

@implementation UserAnnotationView

- (void)setBounds:(CGRect)bounds
{
//    bounds.size = CGSizeMake(cellwidth, cellheight);
//    [super setBounds:bounds];
}

- (void)setAnnotation:(UserAnnotation*)annotation {
    [super setAnnotation:annotation];
    
    self.image = [UIImage imageNamed:annotation.persion.avatarUrl]; // 可能需要从网络获取
    /**
     self.image 影响到frame，所以可以用bounds重新设定一下
     或者先set一个默认底图，然后add一个uiimageview做subview，然后去setimageWithUrl
    */
}

@end

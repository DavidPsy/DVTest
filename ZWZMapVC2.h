//
//  ZWZMapVC2.h
//  gannicus
//
//  Created by pan Shiyu on 13-11-11.
//  Copyright (c) 2013年 bbk. All rights reserved.
//

#import "ZWZuser.h"
#import "ZWZStore.h"
#import "ZWZPerson.h"
#import "ZWZRomaMap.h"
#import "ZWZMapStore.h"
#import "ZWZProfileVc.h"
#import "MBProgressHUD.h"
#import "ZWZAnnotationView.h"
#import "MZFormSheetController.h"

@class ZWZMainVc;

/**
 
 1，第一次打开或者点击定位按钮，头像从天下掉下来
 2，自动缩放地图，不超过一定范围 （maxRadius）
 3，用户缩放后关闭地图的自动缩放
 
 */

@interface ZWZMapVC2 : UIViewController<MKMapViewDelegate> {
    
}

@end


@interface UserAnnotation : NSObject <MKAnnotation>
@property (nonatomic,assign)CLLocationCoordinate2D coordinate;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,strong)ZWZPerson *persion;

+ (UserAnnotation*)UserAnnotationWithPersion:(ZWZPerson*)persion;

@end

@interface UserAnnotationView : MKAnnotationView

@end
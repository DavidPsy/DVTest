//
//  DVBaseVC.m
//  DVTest
//
//  Created by pan Shiyu on 13-11-29.
//  Copyright (c) 2013年 psy. All rights reserved.
//

#import "DVBaseVC.h"

@interface DVBaseVC ()
@end

@implementation DVBaseVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"]
//                                                  forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.backgroundColor = DVColorClear;
    
    self.view.backgroundColor = RGBSAME(240);
    
    
    [self checkIfEnableSwipeRight];
    [self checkIfEnableNavGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 

- (void)checkIfEnableNavGesture {
//    if (!_enableNavGesture) {
//        return;
//    }
    
    UISwipeGestureRecognizer *swipeGestureUp=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(onGestureUp)];
    swipeGestureUp.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeGestureUp];
    
    UISwipeGestureRecognizer *swipeGestureDown=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(onGestureDown)];
    swipeGestureDown.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeGestureDown];
}

- (void)checkIfEnableSwipeRight {
    
    if (self.navigationController.viewControllers.count > 0) {
        UIViewController *rootVC = [self.navigationController.viewControllers objectAtIndex:0];
        if (self == rootVC) {
            _enableSwipeBack = NO;
        }
    }
    
    if (!_enableSwipeBack){
        return;
    }
    
    UISwipeGestureRecognizer *swipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(onGestureBack)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeGesture];
}

#pragma mark - 

- (void)onGestureBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onGestureUp {
    if (self.navigationController.navigationBar.hidden) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

- (void)onGestureDown {
    if (!self.navigationController.navigationBar.hidden) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}


@end

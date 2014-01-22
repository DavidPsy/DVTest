//
//  DVRequestDetailsVC.m
//  DVTest
//
//  Created by pan Shiyu on 14-1-5.
//  Copyright (c) 2014年 psy. All rights reserved.
//

#import "DVReqDetailsVC.h"

#import "DVReqResultVC.h"
#import "DVReqEditVC.h"

@implementation DVReqDetailsVC {
    UIPageViewController *_pagesVC;
    NSMutableArray *_subVCs;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _pagesVC = [self.storyboard instantiateViewControllerWithIdentifier:@"pagesVC"];
    _pagesVC.dataSource = self;
    _pagesVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
    _subVCs = [NSMutableArray array];
    
    DVReqResultVC *resultVC = [self.storyboard instantiateViewControllerWithIdentifier:@"reqResult"];
    resultVC.outRequest = self.outRequest;
    
    DVReqEditVC *editVC = [self.storyboard instantiateViewControllerWithIdentifier:@"reqEdit"];
    editVC.outRequest = self.outRequest;
    
    [_subVCs addObject:resultVC];
    [_subVCs addObject:editVC];
    
    [_pagesVC setViewControllers:@[_subVCs[0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:_pagesVC];
    [self.view addSubview:_pagesVC.view];
    [_pagesVC didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController*)subPagefromVC:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[DVReqEditVC class]]) {
        return _subVCs[0];
    } else {
        return _subVCs[1];
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    return [self subPagefromVC:viewController];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    return [self subPagefromVC:viewController];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return [_subVCs count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

@end

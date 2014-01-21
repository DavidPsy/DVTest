//
//  DVRequestDetailsVC.m
//  DVTest
//
//  Created by pan Shiyu on 14-1-5.
//  Copyright (c) 2014年 psy. All rights reserved.
//

#import "DVReqDetailsVC.h"

@interface DVReqDetailsVC ()

@end

@implementation DVReqDetailsVC {
    UIPageViewController *_pagesVC;
    
    NSMutableArray *_subVCs;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _pagesVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PagesVC"];
    _pagesVC.dataSource = self;
    
    _subVCs = [NSMutableArray array];
    
    [_subVCs addObject:[self.storyboard instantiateViewControllerWithIdentifier:@""]];
    [_subVCs addObject:[self.storyboard instantiateViewControllerWithIdentifier:@""]];
    
    [_pagesVC setViewControllers:@[_subVCs[0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    _pagesVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
    [self addChildViewController:_pagesVC];
    [self.view addSubview:_pagesVC.view];
    [_pagesVC didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [_subVCs indexOfObject:viewController];
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    return _subVCs[0];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [_subVCs indexOfObject:viewController];
    
    return _subVCs[0];
    
    if (index == NSNotFound || index == _subVCs.count-1) {
        return nil;
    }
    
    return _subVCs[1];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [_subVCs count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}


@end

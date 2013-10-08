//
//  MessageListVC.m
//  DVTest
//
//  Created by psy on 13-9-27.
//  Copyright (c) 2013年 psy. All rights reserved.
//

#import "RequestListVC.h"

@interface RequestListVC ()

@end

@implementation RequestListVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 

- (IBAction)addRequest {
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"ACTStoryboard" bundle:nil];
//    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"PageCreateRequest"];
//    [self.navigationController pushViewController:vc animated:YES];
    
    
    [self.navigationController performSegueWithIdentifier:@"PageCreateRequest" sender:self];
    
}

@end

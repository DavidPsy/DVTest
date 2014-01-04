//
//  NetResponseVC.m
//  DVTest
//
//  Created by psy on 13-10-8.
//  Copyright (c) 2013年 psy. All rights reserved.
//

#import "NetResponseVC.h"
#import "DataCenter.h"

@interface NetResponseVC ()

@end

@implementation NetResponseVC

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
    
    [self.outRequest run:^(NSDictionary *result, NSError *error) {
        if (error) {
            self.txtView.text = [error description];
        } else {
            self.txtView.text = [result description];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBack {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end

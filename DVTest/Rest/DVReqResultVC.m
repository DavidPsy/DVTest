//
//  NetResponseVC.m
//  DVTest
//
//  Created by psy on 13-10-8.
//  Copyright (c) 2013年 psy. All rights reserved.
//

#import "DVReqResultVC.h"
#import "DataCenter.h"

@interface DVReqResultVC ()

@end

@implementation DVReqResultVC

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

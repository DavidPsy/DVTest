//
//  FirstViewController.m
//  DVTest
//
//  Created by psy on 13-9-24.
//  Copyright (c) 2013年 psy. All rights reserved.
//

#import "FirstViewController.h"

#import "Snake.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapBackground)];
    [self.view addGestureRecognizer:tap];
}


- (IBAction)sendTestURL:(id)sender {
    NSString * url = [NSString stringWithFormat:@"imeituan:%@",self.textView.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

- (void)onTapBackground {
    [self.textView resignFirstResponder];
}

@end

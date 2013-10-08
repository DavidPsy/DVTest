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
}


- (IBAction)sendTestURL:(id)sender {
//    NSString * url = [NSString stringWithFormat:@"imeituan:%@",self.textView.text];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    
    
    NSMutableArray * aa =[NSMutableArray array];
    
    LittleSnake * ss = [[LittleSnake alloc] init];
    [ss initData];
    
    [aa addObject:ss];
    
    [aa removeObject: aa];
}

@end

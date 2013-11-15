//
//  SecondViewController.h
//  DVTest
//
//  Created by psy on 13-9-24.
//  Copyright (c) 2013年 psy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SnakeVC : UIViewController

@property (weak) IBOutlet UILabel *label;
@property (weak) IBOutlet UIView *panel;

- (IBAction)sliderValueChanged:(UISlider*)sender;

- (IBAction)statusChanged;
- (IBAction)resetGameStatus;

@end


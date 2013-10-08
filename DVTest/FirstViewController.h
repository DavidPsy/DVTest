//
//  FirstViewController.h
//  DVTest
//
//  Created by psy on 13-9-24.
//  Copyright (c) 2013年 psy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController

@property (strong) IBOutlet UITextView *textView;

- (IBAction)sendTestURL:(id)sender;

@end

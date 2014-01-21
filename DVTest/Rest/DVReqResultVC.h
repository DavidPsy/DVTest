//
//  NetResponseVC.h
//  DVTest
//
//  Created by psy on 13-10-8.
//  Copyright (c) 2013年 psy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataCenter.h"

@interface DVReqResultVC : UIViewController
@property (nonatomic,strong)DVRequest *outRequest;
@property (nonatomic,strong)IBOutlet UITextView *txtView;


- (IBAction)onBack;

@end

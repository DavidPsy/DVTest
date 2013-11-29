//
//  FirstViewController.h
//  DVTest
//
//  Created by psy on 13-9-24.
//  Copyright (c) 2013年 psy. All rights reserved.
//

#import "DVBaseVC.h"
#import "DataCenter.h"
 
@interface JumpsVC : DVBaseVC <UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong) IBOutlet UITextView *textView;
@property (strong) IBOutlet UITextField *schemaTextfield;
@property (strong) IBOutlet UITextField *tagTextfield;

@property (strong) IBOutlet UICollectionView *cachesView;

- (IBAction)sendTestURL:(id)sender;
- (IBAction)updateOpenUnit;

@end


typedef void(^TapBlock)(DVOpenAppUnit *tmpUnit);

@interface OpenAppUnitCell : UICollectionViewCell

@property(copy) void(^TapBlock)();
@property(nonatomic,weak)DVOpenAppUnit *refPushUnit;
@property (strong)IBOutlet UILabel *tagLabel;

@end
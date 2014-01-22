//
//  ACTDetailVC.h
//  DVTest
//
//  Created by psy on 13-9-29.
//  Copyright (c) 2013年 psy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DVPageContentVC.h"

#import "DataCenter.h"

@interface DVReqEditVC : DVPageContentVC<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)IBOutlet UITableView *paramsListView;
@property (nonatomic,strong)IBOutlet UITextField *baseURLTextfield;
@property (nonatomic,strong)IBOutlet UITextField *tagTextfield;

@property (nonatomic,strong) DVRequest *outRequest;

- (IBAction)onCreate;

- (IBAction)onAdd;
- (IBAction)onExecute;

@end



#pragma mark - 

@interface ParamTableCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic,strong)IBOutlet UITextField *keyTextfield;
@property (nonatomic,strong)IBOutlet UITextField *valueTextfield;

@property (nonatomic,strong)DVParam *refParam;

- (IBAction)onUpdateParam;

@end

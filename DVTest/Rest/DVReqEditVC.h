//
//  ACTDetailVC.h
//  DVTest
//
//  Created by psy on 13-9-29.
//  Copyright (c) 2013年 psy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataCenter.h"

@class ParamTableCell;
@protocol ParamProtocol <NSObject>
- (void)onDeleteParam:(ParamTableCell*)cell;
@end

@interface DVReqEditVC : UIViewController<UITableViewDataSource,UITableViewDelegate,ParamProtocol>
@property (nonatomic,strong)IBOutlet UITableView *paramsListView;
@property (nonatomic,strong)IBOutlet UITextField *baseURLTextfield;
@property (nonatomic,strong)IBOutlet UITextField *tagTextfield;

@property (nonatomic,strong) DVRequest *outRequest;

- (IBAction)onCreate;
- (IBAction)onAdd;

@end



#pragma mark - 

@interface ParamTableCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic,strong)IBOutlet UITextField *keyTextfield;
@property (nonatomic,strong)IBOutlet UITextField *valueTextfield;

@property (nonatomic,strong)DVParam *refParam;
@property (nonatomic,weak) id<ParamProtocol> delegate;

- (IBAction)onDeleteParam;
- (void)updateData;

@end

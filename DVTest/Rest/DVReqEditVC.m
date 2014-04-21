//
//  ACTDetailVC.m
//  DVTest
//
//  Created by psy on 13-9-29.
//  Copyright (c) 2013年 psy. All rights reserved.
//

#import "DVReqEditVC.h"

#import "DataCenter.h"
#import "DVReqResultVC.h"

@implementation DVReqEditVC {
    NSMutableArray *_paramArray;
}

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
    
    _paramArray = [NSMutableArray array];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapBackground)];
    [self.view addGestureRecognizer:tap];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!_outRequest) {
        return;
    }
    
    self.baseURLTextfield.text = _outRequest.baseURL;
    self.tagTextfield.text = _outRequest.tag;
    _paramArray = [_outRequest paramsArray];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _paramArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"paramTableCell";
    ParamTableCell *tmpCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (tmpCell == nil) {
        tmpCell = [[ParamTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    tmpCell.delegate = self;
    tmpCell.refParam = [_paramArray objectAtIndex:indexPath.row];
    tmpCell.keyTextfield.text = tmpCell.refParam.key;
    tmpCell.valueTextfield.text = tmpCell.refParam.value;
    
    return tmpCell;
}


#pragma mark textfield
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

#pragma mark -

- (IBAction)onCreate {
    if (self.baseURLTextfield.text.length < 5) {
        DVAlert(@"please input base url");
    }
    
    if ([self.tagTextfield.text length] < 1) {
        DVAlert(@"please input a tag");
    }
    
    
    for (int i=0; i<[self.paramsListView numberOfRowsInSection:0]; i++) {
        ParamTableCell *cell = (ParamTableCell*)[self.paramsListView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [cell updateData];
    }
    
    NSArray *Params = [_paramArray mapCar:^id(DVParam *obj, NSUInteger idx, BOOL *stop) {
        if (obj && obj.key.length > 0 && obj.value.length > 0) {
            return obj;
        }
        return nil;
    }];
    
    DVRequest *newRequest = [[DVRequest alloc] initWithURL:self.baseURLTextfield.text paramsList:Params tag:self.tagTextfield.text];
    if (newRequest) {
        [[DataCenter sharedDataCenter] appendRequest:newRequest];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onAdd {
    DVParam *newParam = [[DVParam alloc] init];
    [_paramArray addObject:newParam];
    
    [self.paramsListView reloadData];
}

- (void)onTapBackground {
    [self setEditing:NO];
}

- (void)onDeleteParam:(ParamTableCell*)cell {
    [_paramArray removeObject:cell.refParam];
    
    NSIndexPath *indexpath = [self.paramsListView indexPathForCell:cell];
    [self.paramsListView deleteRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationMiddle];
    
//    [self.paramsListView reloadData];
}

@end


#pragma mark - cell

@implementation ParamTableCell

- (IBAction)onDeleteParam {
    [_delegate onDeleteParam:self];
}

- (void)updateData {
    if (!_refParam) {
        return;
    }
    _refParam.key = _keyTextfield.text;
    _refParam.value = _valueTextfield.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end

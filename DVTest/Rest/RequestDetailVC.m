//
//  ACTDetailVC.m
//  DVTest
//
//  Created by psy on 13-9-29.
//  Copyright (c) 2013年 psy. All rights reserved.
//

#import "RequestDetailVC.h"

#import "DataCenter.h"
#import "NetResponseVC.h"

@implementation RequestDetailVC {
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
    DVRequest *newRequest = [[DVRequest alloc] initWithURL:self.baseURLTextfield.text paramsList:_paramArray tag:self.tagTextfield.text];
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

- (IBAction)onExecute {
    DVRequest *newRequest = [[DVRequest alloc] initWithURL:self.baseURLTextfield.text paramsList:_paramArray tag:self.tagTextfield.text];
    if (!newRequest) {
        return;
    }
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    NetResponseVC *vc = [sb instantiateViewControllerWithIdentifier:@"netresponse"];
    vc.outRequest = newRequest;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)onTapBackground {
    [self setEditing:NO];
}

@end


#pragma mark - cell

@implementation ParamTableCell

- (IBAction)onUpdateParam {
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

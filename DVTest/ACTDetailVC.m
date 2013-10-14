//
//  ACTDetailVC.m
//  DVTest
//
//  Created by psy on 13-9-29.
//  Copyright (c) 2013年 psy. All rights reserved.
//

#import "ACTDetailVC.h"

#import "DataCenter.h"
#import "NetResponseVC.h"

@implementation ACTDetailVC {
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"1");
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"2");
}


#pragma mark textfield
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}


#pragma mark - 

- (IBAction)onBack {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)onCreate {
    DVRequest *newRequest = [[DVRequest alloc] initWithURL:self.baseURLTextfield.text paramsList:_paramArray];
    if (newRequest) {
        [[DataCenter sharedDataCenter].requestList addObject:newRequest];
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)onAdd {
    DVParam *newParam = [[DVParam alloc] init];
    [_paramArray addObject:newParam];
    
    [self.paramsListView reloadData];
}

- (IBAction)onExecute {
    DVRequest *newRequest = [[DVRequest alloc] initWithURL:self.baseURLTextfield.text paramsList:_paramArray];
    if (!newRequest) {
        return;
    }
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    NetResponseVC *vc = [sb instantiateViewControllerWithIdentifier:@"netresponse"];
    vc.outRequest = newRequest;
//    [self.navigationController pushViewController:vc animated:YES];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

- (void)onTapBackground {
    
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

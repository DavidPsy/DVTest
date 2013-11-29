//
//  FirstViewController.m
//  DVTest
//
//  Created by psy on 13-9-24.
//  Copyright (c) 2013年 psy. All rights reserved.
//

#import "JumpsVC.h"
#import "DVTools.h"
#import "DataCenter.h"

@implementation JumpsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapBackground)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
    self.cachesView.delaysContentTouches = NO;
}

- (IBAction)sendTestURL:(id)sender {
    NSString *schema = _schemaTextfield.text;
    NSString *content = _textView.text;
    
    if (schema.length < 2 || content.length < 2) {
        DVAlert(@"少侠，输入点信息吧");
        return;
    }
    
    NSString * url = [NSString stringWithFormat:@"%@:%@",schema,content];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

- (IBAction)updateOpenUnit {
    DVOpenAppUnit *newUnit = [[DVOpenAppUnit alloc]initWithSchema:_schemaTextfield.text content:_textView.text tag:_tagTextfield.text];
    if (newUnit) {
        [[DataCenter sharedDataCenter] appendPush:newUnit];
        [_cachesView reloadData];
    }else {
        DVAlert(@"信息不全？");
    }
}

- (void)onTapBackground {
    [self.view endEditing:YES];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText: (NSString *)text
{
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)updateSelf:(DVOpenAppUnit*)tmpUnit {
    _schemaTextfield.text = tmpUnit.schema;
    _textView.text = tmpUnit.content;
    _tagTextfield.text = tmpUnit.tag;
}


#pragma mark - collections delegate
//集合代理-每一部分数据项
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [DataCenter sharedDataCenter].openAppList.count;
}


//Cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"OpenAppUnitCell";
    OpenAppUnitCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    DVOpenAppUnit *tmpUnit = [[DataCenter sharedDataCenter].openAppList objectAtIndex:indexPath.row];
    cell.refPushUnit = tmpUnit;
    return cell;
}

//代理－选择行的触发事件

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DVOpenAppUnit *tmpUnit = [[DataCenter sharedDataCenter].openAppList objectAtIndex:indexPath.row];
    [self updateSelf:tmpUnit];
}


@end


@implementation OpenAppUnitCell

- (void)setRefPushUnit:(DVOpenAppUnit *)refPushUnit {
    _refPushUnit = refPushUnit;
    if (_refPushUnit) {
        _tagLabel.text = _refPushUnit.tag;
    }
}

- (IBAction)onTapUnit {
    if (_TapBlock) {
        _TapBlock();
    }
}

@end




//
//  MessageListVC.m
//  DVTest
//
//  Created by psy on 13-9-27.
//  Copyright (c) 2013年 psy. All rights reserved.
//

#import "DVRequestListVC.h"
#import "DataCenter.h"
#import "DVReqEditVC.h"
#import "DVReqDetailsVC.h"

@implementation DVRequestListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.listView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [DataCenter sharedDataCenter].requestList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"requestTableCell";
    RequestTableCell *tmpCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (tmpCell == nil) {
        tmpCell = [[RequestTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    tmpCell.refRequest = [[DataCenter sharedDataCenter].requestList objectAtIndex:indexPath.row];
    tmpCell.textLabel.text = tmpCell.refRequest.baseURL;
    tmpCell.detailTextLabel.text = tmpCell.refRequest.tag;
    
    return tmpCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DVRequest *aRequest = [[DataCenter sharedDataCenter].requestList objectAtIndex:indexPath.row];
    
    [aRequest run:^(NSDictionary *result, NSError *error) {
        
    }];
    DVReqDetailsVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"reqDetails"];
    vc.outRequest = aRequest;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - 

- (IBAction)addRequest {
    
    [self performSegueWithIdentifier:@"testSegue" sender:self];
}

@end


#pragma mark - tableview delegate


#pragma mark - 

@implementation RequestTableCell


@end

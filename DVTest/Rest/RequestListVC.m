//
//  MessageListVC.m
//  DVTest
//
//  Created by psy on 13-9-27.
//  Copyright (c) 2013年 psy. All rights reserved.
//

#import "RequestListVC.h"
#import "DataCenter.h"
#import "RequestDetailVC.h"

@implementation RequestListVC {
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

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
    DVRequest *tmpRequest = [[DataCenter sharedDataCenter].requestList objectAtIndex:indexPath.row];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    RequestDetailVC *vc = [sb instantiateViewControllerWithIdentifier:@"RequestDetail"];
    vc.outRequest = tmpRequest;
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

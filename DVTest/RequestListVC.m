//
//  MessageListVC.m
//  DVTest
//
//  Created by psy on 13-9-27.
//  Copyright (c) 2013年 psy. All rights reserved.
//

#import "RequestListVC.h"
#import "DataCenter.h"
#import "ACTDetailVC.h"

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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
//    self.listView.edgesForExtendedLayout = UIRectEdgeNone;
    self.edgesForExtendedLayout = UIRectEdgeNone;
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
    
    return tmpCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DVRequest *tmpRequest = [[DataCenter sharedDataCenter].requestList objectAtIndex:indexPath.row];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    ACTDetailVC *vc = [sb instantiateViewControllerWithIdentifier:@"PageCreateRequest"];
    
    vc.outRequest = tmpRequest;
    
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;

#pragma mark - 

- (IBAction)addRequest {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"PageCreateRequest"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end


#pragma mark - tableview delegate




#pragma mark - 

@implementation RequestTableCell


@end

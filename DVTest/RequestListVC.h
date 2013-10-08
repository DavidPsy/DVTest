//
//  MessageListVC.h
//  DVTest
//
//  Created by psy on 13-9-27.
//  Copyright (c) 2013年 psy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataCenter.h"

@interface RequestListVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)IBOutlet UITableView *listView;
- (IBAction)addRequest;


@end



@interface RequestTableCell : UITableViewCell
@property (nonatomic,strong)DVRequest *refRequest;

@end

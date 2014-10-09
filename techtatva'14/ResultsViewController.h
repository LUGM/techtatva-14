//
//  ResultsViewController.h
//  techtatva'14
//
//  Created by Shubham Sorte on 23/09/14.
//  Copyright (c) 2014 LUG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSJSONModel.h"

@interface ResultsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,SSJSONModelDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTable;

@end

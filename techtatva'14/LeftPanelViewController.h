//
//  LeftPanelViewController.h
//  techtatva'14
//
//  Created by Shubham Sorte on 23/08/14.
//  Copyright (c) 2014 Apps2eaze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JASidePanelController.h"

@interface LeftPanelViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    UITableView* myTable;
}


@end

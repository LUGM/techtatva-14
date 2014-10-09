//
//  ViewController.h
//  techtatva'14
//
//  Created by Shubham Sorte on 22/08/14.
//  Copyright (c) 2014 Apps2eaze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JASidePanelController.h"
#import "RightButtonNavBar.h"
#import "SSJSONModel.h"
#import "AppDelegate.h"



@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,SSJSONModelDelegate,UIAlertViewDelegate>
{
    UITableView * myTable;
}




@end

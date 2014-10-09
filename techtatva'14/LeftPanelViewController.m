//
//  LeftPanelViewController.m
//  techtatva'14
//
//  Created by Shubham Sorte on 23/08/14.
//  Copyright (c) 2014 Apps2eaze. All rights reserved.
//

#import "LeftPanelViewController.h"
#import "UIViewController+JASidePanel.h"
#import "ViewController.h"
#import "AppDelegate.h"

@interface LeftPanelViewController ()
{
    NSArray * imagesArray;
    NSArray * catNames;
    AppDelegate * appDelegate;
}

@end

@implementation LeftPanelViewController

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
    
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    self.view.backgroundColor = [UIColor whiteColor];
    myTable =[[UITableView alloc]init];
    myTable.delegate =self;
    myTable.dataSource =self;
    myTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    myTable.frame = CGRectMake(0, 22, self.view.frame.size.width, self.view.frame.size.height-22);
    [self.view addSubview:myTable];
    
    imagesArray = [NSArray arrayWithObjects:@"80p.png",@"turing.jpg",@"mechatron.jpg",@"airborne.jpg",@"electrific.jpg",@"epsilon.jpg",@"energia.jpg",@"acumen.jpg",@"cryptoss.jpg",@"robotrek.jpg",@"cheminova.jpg",@"constructure.jpg",@"buzzmaestro.jpg",@"mechanize.jpg",@"kraftwagen.jpg",@"gizmo.jpg", nil];
    
    catNames = @[@"Snapshot",@"Turing",@"Mechatron",@"Airborn",@"Electrific",@"Epsilon",@"Energia",@"Acumen",@"Cryptoss",@"Robotrek",@"Cheminova",@"Constructure",@"BizZmaestro",@"Mechanize",@"Kraftwagen",@"Gizmo"];
    
    myTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [catNames count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"Cell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    
    cell.textLabel.text = [catNames objectAtIndex:indexPath.row];

    cell.imageView.image = [UIImage imageNamed:[imagesArray objectAtIndex:indexPath.row]];
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        appDelegate.globalEventCategory = @"Snapshot";
    }
    if (indexPath.row == 1) {
        appDelegate.globalEventCategory = @"Turing";
    }
    if (indexPath.row == 2) {
        appDelegate.globalEventCategory = @"Mechatron";
    }
    if (indexPath.row == 3) {
        appDelegate.globalEventCategory = @"Airborn";
    }
    if (indexPath.row == 4) {
        appDelegate.globalEventCategory = @"Electrific";
    }
    if (indexPath.row == 5) {
        appDelegate.globalEventCategory = @"Epsilon";
    }
    if (indexPath.row == 6) {
        appDelegate.globalEventCategory = @"Energia";
    }
    if (indexPath.row == 7) {
        appDelegate.globalEventCategory = @"Acumen";
    }
    if (indexPath.row == 8) {
        appDelegate.globalEventCategory = @"Cryptoss";
    }
    if (indexPath.row == 9) {
        appDelegate.globalEventCategory = @"Robotrek";
    }
    if (indexPath.row == 10) {
        appDelegate.globalEventCategory = @"Cheminova";
    }
    if (indexPath.row == 11) {
        appDelegate.globalEventCategory = @"Constructure";
    }
    if (indexPath.row == 12) {
        appDelegate.globalEventCategory = @"BizZmaestro";
    }
    if (indexPath.row == 13) {
        appDelegate.globalEventCategory = @"Mechanize";
    }
    if (indexPath.row == 14) {
        appDelegate.globalEventCategory = @"Kraftwagen";
    }
    if (indexPath.row == 15) {
        appDelegate.globalEventCategory = @"Gizmo";
    }

    
    [self _showTapped];
}

- (void)_showTapped{
    self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

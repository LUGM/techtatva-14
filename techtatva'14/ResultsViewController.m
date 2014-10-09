//
//  ResultsViewController.m
//  techtatva'14
//
//  Created by Shubham Sorte on 23/09/14.
//  Copyright (c) 2014 LUG. All rights reserved.
//

#import "ResultsViewController.h"
#import "HUD.h"

@interface ResultsViewController (){
    SSJSONModel * jsonModelInstance;
    
    NSMutableArray *catNames;
    NSMutableArray *eventNames;
    NSMutableArray *eventResults;
    
    NSArray *json;
}

@end

@implementation ResultsViewController

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
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    self.title = @"Results";
    
    
    NSURL * mainUrl = [NSURL URLWithString:@"http://results.techtatva.in"];
    
    jsonModelInstance = [[SSJSONModel alloc] initWithDelegate:self];
    [jsonModelInstance sendRequestWithUrl:mainUrl];
    [HUD showUIBlockingIndicatorWithText:@"Loading"];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Home" style:UIBarButtonItemStylePlain target:self action:@selector(homeView)];    

}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
-(void)homeView{
//    UIStoryboard * mainStoryBoard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:[NSBundle mainBundle]];
//    
//    
//    UINavigationController * viewController =[mainStoryBoard instantiateViewControllerWithIdentifier:@"SidePanel"];
//    
//    [self presentViewController:viewController animated:YES completion:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)jsonRequestDidCompleteWithDict:(NSArray *)array model:(SSJSONModel *)JSONModel
{
    json = [[NSMutableArray alloc]init];
    
    json = jsonModelInstance.jsonDictionary;
    
    catNames =[[NSMutableArray alloc]init];
    eventNames=[[NSMutableArray alloc]init];
    eventResults =[[NSMutableArray alloc]init];
    
    for (int i = 0; i<[json count]; i++) {
        [catNames addObject:[[json objectAtIndex:i] objectForKey:@"Category"]];
        [eventNames addObject:[[json objectAtIndex:i] objectForKey:@"Event"]];
        [eventResults addObject:[[json objectAtIndex:i] objectForKey:@"Result"]];

    }
    [_myTable reloadData];
    [HUD hideUIBlockingIndicator];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return json.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell.textLabel.text = [catNames objectAtIndex:indexPath.row]
    ;
    cell.detailTextLabel.text = [eventNames objectAtIndex:indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView * alert = [[UIAlertView alloc ]initWithTitle:[eventNames objectAtIndex:indexPath.row] message:[eventResults objectAtIndex:indexPath.row] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * blankView = [[UIView alloc]initWithFrame:CGRectZero];
    
    return blankView;
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

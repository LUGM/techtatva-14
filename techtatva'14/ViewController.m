//
//  ViewController.m
//  techtatva'14
//
//  Created by Shubham Sorte on 22/08/14.
//  Copyright (c) 2014 Apps2eaze. All rights reserved.
//


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#import "ViewController.h"
#import "EventTableViewCell.h"
#import "DayView.h"
#import "RightButtonNavBar.h"
#import "IKCollectionViewController.h"
#import "HUD.h"
#import "Reachability.h"
#import "AppDelegate.h"


@interface ViewController (){
    SSJSONModel * jsonModelInstance;
    
    NSMutableArray * eventNames;
    NSMutableArray *eventDay;
    NSMutableArray *eventDescription;
    NSMutableArray *eventLocation;
    NSMutableArray *eventDuration;
    NSMutableArray *eventDate;
    NSMutableArray *eventContact;
    
    NSArray * json;
    Reachability * internetReachableFoo;
    UIView * blurView;
    
    UIAlertView * connectAlert;
    
    AppDelegate * appDelegate;
}

@property DayView *dayView;
@property RightButtonNavBar *rightMenu;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _rightMenu = nil;
    blurView = nil;

    appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];

    if (appDelegate.globalEventCategory == nil) {
        appDelegate.globalEventCategory = @"Snapshot";
    }
    
    if (appDelegate.globalEventDay == nil) {
        appDelegate.globalEventDay = @"8/10/2014";
    }
    
    if (self.dayView == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DayView" owner:self options:nil];
        _dayView = [nib objectAtIndex:0];
        _dayView.frame = CGRectMake(0, 64, 320, 50);
        _dayView.alpha = 0.85;
        [_dayView.dayOneButtonPressed addTarget:self action:@selector(changeToDayOne) forControlEvents:UIControlEventTouchUpInside];
        [_dayView.dayTwoButtonPressed addTarget:self action:@selector(changeToDayTwo) forControlEvents:UIControlEventTouchUpInside];
        [_dayView.dayThreeButtonPressed addTarget:self action:@selector(changeToDayThree) forControlEvents:UIControlEventTouchUpInside];
        [_dayView.dayFourButtonPressed addTarget:self action:@selector(changeToDayFour) forControlEvents:UIControlEventTouchUpInside];
        
    }
    

    
    myTable = [[UITableView alloc]initWithFrame:CGRectMake(10,0, self.view.frame.size.width-20, self.view.frame.size.height)];
    myTable.delegate = self;
    myTable.dataSource = self;
    // 0x2c3e50 cfcfcf
    myTable.backgroundColor = UIColorFromRGB(0xdddddd);
    myTable.separatorColor = UIColorFromRGB(0xdddddd);
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTable.showsVerticalScrollIndicator = NO;
    self.view.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.view addSubview:myTable];
    [self.view addSubview:_dayView];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(showMenu)];
    
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.title = appDelegate.globalEventCategory;
    
    if (![self connected]) {
        [HUD showUIBlockingIndicatorWithText:@"Loading"];
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        NSLog(@"Data is %@",[defaults objectForKey:@"offlineData"]);
        
        if ([defaults objectForKey:@"offlineData"]!=nil) {
            json = [defaults objectForKey:@"offlineData"];
            
            [self settingArrayValues];

        }
        else{
            connectAlert = [[UIAlertView alloc] initWithTitle:@"Data not available"
                                                      message:@"Please check your\nconnection"
                                                     delegate:self
                                            cancelButtonTitle:@"Retry" otherButtonTitles:nil, nil];
            [connectAlert show];
        }
        [self viewDidLayoutSubviews];
    }
    
    else {
        [self sendTheRequst];
    }
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)sendTheRequst{
    
    NSURL * mainUrl = [NSURL URLWithString:@"http://schedule.techtatva.in"];
    
    jsonModelInstance = [[SSJSONModel alloc] initWithDelegate:self];
    [jsonModelInstance sendRequestWithUrl:mainUrl];
    [HUD showUIBlockingIndicatorWithText:@"Loading"];
    
}

-(void)viewDidLayoutSubviews
{
    myTable.contentInset = UIEdgeInsetsMake(60+54, 0, 0, 0);
}

-(void)jsonRequestDidCompleteWithDict:(NSDictionary *)dict model:(SSJSONModel *)JSONModel
{
    [HUD hideUIBlockingIndicator];
    if (JSONModel == jsonModelInstance) {
//        NSLog(@"json is %@",jsonModelInstance.jsonDictionary) ;
        
        json = jsonModelInstance.jsonDictionary;
        
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        [defaults setObject:json forKey:@"offlineData"];
        [defaults synchronize];
        
        [self settingArrayValues];
    }
}

-(void)settingArrayValues{
    
    
    eventNames = [[NSMutableArray alloc] init];
    eventDescription = [[NSMutableArray alloc] init];
    eventLocation = [[NSMutableArray alloc] init];
    eventDate = [[NSMutableArray alloc]init];
    eventDay = [[NSMutableArray alloc]init];
    eventContact = [[NSMutableArray alloc]init];
    eventDuration = [[NSMutableArray alloc ]init];
    for (int i = 0; i<[json count]; i++) {

    if ([appDelegate.globalEventCategory isEqualToString:@"Snapshot"]) {
            if ([[[json objectAtIndex:i] objectForKey:@"Date"] isEqualToString: appDelegate.globalEventDay]) {
                [eventNames addObject:[[json objectAtIndex:i] objectForKey:@"Event"]];
                [eventDescription addObject:[[json objectAtIndex:i] objectForKey:@"Description"]];
                [eventLocation addObject:[[json objectAtIndex:i] objectForKey:@"Location"]];
                [eventDate addObject:[[json objectAtIndex:i] objectForKey:@"Date"]];
                [eventContact addObject:[[json objectAtIndex:i] objectForKey:@"Contact"]];
                [eventDuration addObject:[[json objectAtIndex:i] objectForKey:@"Duration"]];
            }
        }
    else if([[[json objectAtIndex:i] objectForKey:@"Category"] isEqualToString: appDelegate.globalEventCategory]) {
            if ([[[json objectAtIndex:i] objectForKey:@"Date"] isEqualToString: appDelegate.globalEventDay]) {
                [eventNames addObject:[[json objectAtIndex:i] objectForKey:@"Event"]];
                [eventDescription addObject:[[json objectAtIndex:i] objectForKey:@"Description"]];
                [eventLocation addObject:[[json objectAtIndex:i] objectForKey:@"Location"]];
                [eventDate addObject:[[json objectAtIndex:i] objectForKey:@"Date"]];
                [eventContact addObject:[[json objectAtIndex:i] objectForKey:@"Contact"]];
                [eventDuration addObject:[[json objectAtIndex:i] objectForKey:@"Duration"]];
            }
        }
    }
    [self viewDidLayoutSubviews];
    [myTable reloadData];
    [HUD hideUIBlockingIndicator];
}


-(void)showMenu
{
    
    if (self.rightMenu == nil) {
        
        blurView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        blurView.backgroundColor = [UIColor grayColor];
        blurView.alpha = 0.9;
        [self.view addSubview:blurView];
        [blurView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeBlurAndSubview)]];
        NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"RightButtonNavBar" owner:self options:nil];
        _rightMenu = [nib objectAtIndex:0];
        _rightMenu.frame = CGRectMake(140, 74, 170, 257);
        
        [self.view addSubview:_rightMenu];
        
        [_rightMenu.instaButtonPressed addTarget:self action:@selector(instagramFeedPressed) forControlEvents:UIControlEventTouchUpInside];
        [_rightMenu.developerButtonPressed addTarget:self action:@selector(developerButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [_rightMenu.registerButtonPressed addTarget:self action:@selector(registerButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [_rightMenu.liveblogButtonPressed addTarget:self action:@selector(liveBlogButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        
        [_rightMenu.resultsButtonPressed addTarget:self action:@selector(resultsButton) forControlEvents:UIControlEventTouchUpInside];
        
    }
}

-(void)resultsButton{


    if (![self connected]) {
        UIAlertView * registerViewAlert = [[UIAlertView alloc] initWithTitle:@"Data not available"
                                                                     message:@"Please check your\nconnection"
                                                                    delegate:self
                                                           cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [registerViewAlert show];
    }
    else {
        
        UIStoryboard * mainStoryBoard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:[NSBundle mainBundle]];
        
        
        UINavigationController * viewController =[mainStoryBoard instantiateViewControllerWithIdentifier:@"resultsView"];
        
        [self presentViewController:viewController animated:YES completion:nil];
        
    }

    
}
-(void)liveBlogButtonPressed{
    
    if (![self connected]) {
        UIAlertView * registerViewAlert = [[UIAlertView alloc] initWithTitle:@"Data not available"
                                                                     message:@"Please check your\nconnection"
                                                                    delegate:self
                                                           cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [registerViewAlert show];
    }
    else {
        appDelegate.webViewUrl = @"http://blog.techtatva.in";
        UIStoryboard * mainStoryBoard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:[NSBundle mainBundle]];
        
        
        UINavigationController * viewController =[mainStoryBoard instantiateViewControllerWithIdentifier:@"registerView"];
        
        [self presentViewController:viewController animated:YES completion:nil];
        
    }

    
}
-(void)registerButtonPressed{
    if (![self connected]) {
        UIAlertView * registerViewAlert = [[UIAlertView alloc] initWithTitle:@"Data not available"
                                                                     message:@"Please check your\nconnection"
                                                                    delegate:self
                                                           cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [registerViewAlert show];
    }
    else {
        appDelegate.webViewUrl = @"http://techtatva.in/register.php";
        UIStoryboard * mainStoryBoard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:[NSBundle mainBundle]];
        
        
        UINavigationController * viewController =[mainStoryBoard instantiateViewControllerWithIdentifier:@"registerView"];
        
        [self presentViewController:viewController animated:YES completion:nil];

    }
    
}
-(void)developerButtonPressed{
    UIStoryboard * mainStoryBoard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:[NSBundle mainBundle]];
    
    
    UINavigationController * viewController =[mainStoryBoard instantiateViewControllerWithIdentifier:@"teamView"];
    
    [self presentViewController:viewController animated:YES completion:nil];
}
-(void)instagramFeedPressed
{
    if (![self connected]) {
        UIAlertView * instaNotConnectedAlert = [[UIAlertView alloc] initWithTitle:@"Data not available"
                                                  message:@"Please check your\nconnection"
                                                 delegate:self
                                        cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [instaNotConnectedAlert show];
    }
    else{
    [self.rightMenu removeFromSuperview];
    self.rightMenu = nil;
    
    UIStoryboard * instaFeedStoryboard = [UIStoryboard storyboardWithName:@"Main_insta" bundle:[NSBundle mainBundle]];
    IKCollectionViewController * viewController =[instaFeedStoryboard instantiateInitialViewController];
    
    [self presentViewController:viewController animated:YES completion:nil];
    }
}


-(void)removeBlurAndSubview{
    [_rightMenu removeFromSuperview];
    [blurView removeFromSuperview];
    _rightMenu = nil;
    blurView = nil;
}

- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView == connectAlert) {
        if (buttonIndex == 0) {
            [self viewDidLoad];
        }
    }
    
}

#pragma mark - Changing day Actions

-(void)changeToDayOne{
    appDelegate.globalEventDay = @"8/10/2014";
    [self clearingAllArrays];
    [self settingArrayValues];
    
}

-(void)changeToDayTwo{
    appDelegate.globalEventDay = @"9/10/2014";
    [self clearingAllArrays];
     [self settingArrayValues];
}

-(void)changeToDayThree{
    appDelegate.globalEventDay = @"10/10/2014";
    [self clearingAllArrays];
     [self settingArrayValues];
}

-(void)changeToDayFour{
    appDelegate.globalEventDay = @"11/10/2014";
    [self clearingAllArrays];
     [self settingArrayValues];
}

-(void)clearingAllArrays{
    eventNames = nil;
    eventDescription = nil;
    eventLocation = nil;
    eventDate = nil;
    eventDay = nil;
    eventContact = nil;
    eventDuration = nil;
    eventNames = [[NSMutableArray alloc] init];
    eventDescription = [[NSMutableArray alloc] init];
    eventLocation = [[NSMutableArray alloc] init];
    eventDate = [[NSMutableArray alloc]init];
    eventDay = [[NSMutableArray alloc]init];
    eventContact = [[NSMutableArray alloc]init];
    eventDuration = [[NSMutableArray alloc ]init];
}

#pragma mark - Table View
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [eventNames count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EventTableViewCell *cell = (EventTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    if (cell==nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"EventCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    cell.eventNameLabel.text = [eventNames objectAtIndex:indexPath.row];
    cell.eventDateLabel.text = [eventDate objectAtIndex:indexPath.row];
    cell.eventLocationLabel.text = [eventLocation objectAtIndex:indexPath.row];
    cell.eventDescriptionLabel.text = [eventDescription objectAtIndex:indexPath.row];
    cell.eventContactLabel.text = [eventContact objectAtIndex:indexPath.row];
    cell.eventTimeLabel.text = [eventDuration objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:[eventNames objectAtIndex:indexPath.row] message:[eventDescription objectAtIndex:indexPath.row] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
    
    NSLog(@"Index is %ld",(long)indexPath.row);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,7.5)];
    footer.backgroundColor = [UIColor clearColor];
    
    return footer;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 7.5;
}

@end

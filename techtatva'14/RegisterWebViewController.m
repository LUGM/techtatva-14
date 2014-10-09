//
//  RegisterWebViewController.m
//  techtatva'14
//
//  Created by Shubham Sorte on 22/09/14.
//  Copyright (c) 2014 LUG. All rights reserved.
//

#import "RegisterWebViewController.h"
#import "AppDelegate.h"

@interface RegisterWebViewController () <UIWebViewDelegate>{
    AppDelegate * appDelegate;
}

@end

@implementation RegisterWebViewController

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
    appDelegate =(AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    NSURL *URL = [NSURL URLWithString:appDelegate.webViewUrl];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:URL];
    self.registerWebView.delegate = self ;
    
    [_registerWebView loadRequest:requestObj];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Reload" style:UIBarButtonItemStylePlain target:self action:@selector(viewDidLoad)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Home" style:UIBarButtonItemStylePlain target:self action:@selector(homeView)];
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
-(void)homeView{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

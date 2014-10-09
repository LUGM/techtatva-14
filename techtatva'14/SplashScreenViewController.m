//
//  SplashScreenViewController.m
//  techtatva'14
//
//  Created by Shubham Sorte on 21/09/14.
//  Copyright (c) 2014 Apps2eaze. All rights reserved.
//

#import "SplashScreenViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface SplashScreenViewController (){
    MPMoviePlayerController * mpc;
}

@end

@implementation SplashScreenViewController

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished) name:MPMoviePlayerPlaybackDidFinishNotification object:mpc];
    
    NSString * stringPath = [[NSBundle mainBundle] pathForResource:@"video" ofType:@"mov"];
    
    NSURL * fileUrl = [NSURL fileURLWithPath:stringPath];
    mpc = [[MPMoviePlayerController alloc] initWithContentURL:fileUrl];
    [mpc setMovieSourceType:MPMovieSourceTypeFile];
    [mpc.view setFrame:CGRectMake(0,0,320 ,568)];
    [mpc setFullscreen:YES];
    [mpc setScalingMode:MPMovieScalingModeFill];
    [mpc setControlStyle:MPMovieControlStyleNone];
    [self.view addSubview:mpc.view];
    [mpc play];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
-(void)playbackFinished{
    
    [self performSegueWithIdentifier:@"nextView" sender:self];
    
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

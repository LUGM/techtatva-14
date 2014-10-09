//
//  RightButtonNavBar.h
//  techtatva'14
//
//  Created by Shubham Sorte on 15/09/14.
//  Copyright (c) 2014 Apps2eaze. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface RightButtonNavBar : UIView
{
    
}
- (IBAction)instagramFeed:(id)sender;                       //ignore

@property (weak, nonatomic) IBOutlet UIButton *instaButtonPressed;

@property (weak, nonatomic) IBOutlet UIButton *resultsButtonPressed;

@property (weak, nonatomic) IBOutlet UIButton *registerButtonPressed;

@property (weak, nonatomic) IBOutlet UIButton *developerButtonPressed;

@property (weak, nonatomic) IBOutlet UIButton *liveblogButtonPressed;

@end

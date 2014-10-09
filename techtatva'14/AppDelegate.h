//
//  AppDelegate.h
//  techtatva'14
//
//  Created by Shubham Sorte on 22/08/14.
//  Copyright (c) 2014 Apps2eaze. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JASidePanelController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong,nonatomic) JASidePanelController * viewController;
@property (strong,nonatomic) NSString *globalEventCategory;
@property (strong,nonatomic) NSString *globalEventDay;

@property(strong,nonatomic) NSString * webViewUrl;

@end

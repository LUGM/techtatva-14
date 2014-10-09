//
//  EventTableViewCell.h
//  techtatva'14
//
//  Created by Shubham Sorte on 22/08/14.
//  Copyright (c) 2014 Apps2eaze. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *eventNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *eventDescriptionLabel;

@property (weak, nonatomic) IBOutlet UILabel *eventLocationLabel;

@property (weak, nonatomic) IBOutlet UILabel *eventTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *eventDateLabel;

@property (weak, nonatomic) IBOutlet UILabel *eventContactLabel;

@end

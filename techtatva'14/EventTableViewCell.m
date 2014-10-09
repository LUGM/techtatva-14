//
//  EventTableViewCell.m
//  techtatva'14
//
//  Created by Shubham Sorte on 22/08/14.
//  Copyright (c) 2014 Apps2eaze. All rights reserved.
//

#import "EventTableViewCell.h"

@implementation EventTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setFrame:(CGRect)frame
{
    frame.origin.y += 6;
    frame.size.height -= 6;
    [super setFrame:frame];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

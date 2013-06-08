//
//  HeaderView.m
//  QQTableView
//
//  Created by Xinjun Email on 22/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView
@synthesize accessaryView;
@synthesize nameLabel;
@synthesize totalNumLabel;
@synthesize buttonInHeader;
@synthesize disclosureButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc {
    [accessaryView release];
    [nameLabel release];
    [totalNumLabel release];
    [buttonInHeader release];
    [disclosureButton release];
    [super dealloc];
}
@end

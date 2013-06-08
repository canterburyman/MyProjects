//
//  GroupInTableViewController.m
//  QQTableView
//
//  Created by Xinjun Email on 21/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GroupInTableViewController.h"

@interface GroupInTableViewController ()

@property (nonatomic, retain) NSArray *groupNames;

@property (nonatomic, retain) NSDictionary *usersInGroupDict;

@end

@implementation GroupInTableViewController
@synthesize groupNames, usersInGroupDict;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.groupNames = [NSArray arrayWithObjects:@"group1", @"group2", nil];
        usersInGroupDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:@"user1", @"user2", nil], [self.groupNames objectAtIndex:0],
                            [NSArray arrayWithObjects:@"user11", @"user12", nil], [self.groupNames objectAtIndex:1], nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

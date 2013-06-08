//
//  TestSwitchViewController.m
//  QQTableView
//
//  Created by Xinjun Email on 26/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TestSwitchViewController.h"

@interface TestSwitchViewController ()

@end

@implementation TestSwitchViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)swiButton:(UISwitch *)sender {
}
@end

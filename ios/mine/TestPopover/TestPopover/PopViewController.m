//
//  PopViewController.m
//  TestPopover
//
//  Created by Jane Ching on 11/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PopViewController.h"
#import "Popover/WEPopoverController.h"
#import "PopContentViewController.h"
@interface PopViewController ()
@property (retain, nonatomic) WEPopoverController *popvc;
@end

@implementation PopViewController
@synthesize popvc;

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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"popoverArrowDown.png"]  style:UIBarButtonItemStyleBordered target:self action:@selector(clickBarButton:)];
    
//    UIButton *settingsView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//    [settingsView addTarget:self action:@selector(SettingsClicked) forControlEvents:UIControlEventTouchUpInside];
//    [settingsView setBackgroundImage:[UIImage imageNamed:@"arrow_down.png"] forState:UIControlStateNormal];
//    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithCustomView:settingsView];
//    [self.navigationItem setRightBarButtonItem:settingsButton];
    
}

-(void) clickBarButton:(UIBarButtonItem *) button
{
    PopContentViewController *pcvc = [[PopContentViewController alloc] initWithStyle:UITableViewStylePlain];
    self.popvc = [[[WEPopoverController alloc] initWithContentViewController:pcvc] autorelease];
    popvc.containerViewProperties = [self improvedContainerViewProperties];
    [popvc presentPopoverFromBarButtonItem:button permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
    [self performSelector:@selector(dismissPopOver) withObject:self afterDelay:2];

    
}
     
-(void) dismissPopOver
{
    [self.popvc dismissPopoverAnimated:YES];
}

- (WEPopoverContainerViewProperties *)improvedContainerViewProperties {
	
	WEPopoverContainerViewProperties *props = [[WEPopoverContainerViewProperties alloc] autorelease];
	NSString *bgImageName = nil;
	CGFloat bgMargin = 0.0;
	CGFloat bgCapSize = 0.0;
	CGFloat contentMargin = 4.0;
	
	bgImageName = @"popoverBg.png";
	
	// These constants are determined by the popoverBg.png image file and are image dependent
	bgMargin = 13; // margin width of 13 pixels on all sides popoverBg.png (62 pixels wide - 36 pixel background) / 2 == 26 / 2 == 13 
	bgCapSize = 31; // ImageSize/2  == 62 / 2 == 31 pixels
	
	props.leftBgMargin = bgMargin;
	props.rightBgMargin = bgMargin;
	props.topBgMargin = bgMargin;
	props.bottomBgMargin = bgMargin;
	props.leftBgCapSize = bgCapSize;
	props.topBgCapSize = bgCapSize;
	props.bgImageName = bgImageName;
	props.leftContentMargin = contentMargin;
	props.rightContentMargin = contentMargin - 1; // Need to shift one pixel for border to look correct
	props.topContentMargin = contentMargin; 
	props.bottomContentMargin = contentMargin;
	
	props.arrowMargin = 4.0;
	
	props.upArrowImageName = @"popoverArrowUp.png";
	props.downArrowImageName = @"popoverArrowDown.png";
	props.leftArrowImageName = @"popoverArrowLeft.png";
	props.rightArrowImageName = @"popoverArrowRight.png";
	return props;	
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

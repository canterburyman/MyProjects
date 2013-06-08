//
//  DotPickerView.m
//  Popover
//
//  Created by Xinkai wang on 10/14/10.
//  Copyright 2010 MSFT. All rights reserved.
//

#import "DotPickerView.h"
#import "Resources.h"

@implementation DotPickerView

@synthesize delegate;

- (IBAction) onOK:(id)sender
{
	[delegate DotImagePicked:[picker selectedRowInComponent:0] source:self];
	[self.navigationController popViewControllerAnimated:YES];
}

// this name includes extention. "BlueDot.png"
- (void) setCurrentSelection:(NSString*)dotImageName
{
	int i = 0;
	for (NSString * name in [Resources dotImageNames])
	{
		if ([[name stringByAppendingString:@".png"] isEqual:dotImageName]) 
		{
			if (picker != nil)
			{
				currentSelection = i;
				[picker selectRow:i inComponent:0 animated:NO];
			}
			else
			{
				currentSelection = i;
			}

			return;
		}
		i++;
	}
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

-(void)viewWillAppear:(BOOL)animated
{
	[picker selectRow:currentSelection inComponent:0 animated:NO];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

// UIPickerViewDataSource Protocol
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

// UIPickerViewDataSource Protocol
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [[Resources dotImageNames] count];
}

// UIPickerViewDelegate Protocol
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	return [[Resources dotImageNames] objectAtIndex:row];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
}

- (void)dealloc {
    [super dealloc];
}


@end

//
//  AddDeviceView.m
//  LollpopClientV1
//
//  Created by Xinkai wang on 10/14/10.
//  Copyright 2010 MSFT. All rights reserved.
//

#import "AddDeviceView.h"
#import "Resources.h"

@implementation AddDeviceView

@synthesize delegator;
@synthesize dotImageName;

- (void)save:(id)sender
{
	if (lidTextField.text.length == 0) 
	{
		statusLabel.text = @"LID field can not be empty!";
	}
	else
	{
		// DeviceListView::saveNewDevice()
		[delegator saveNewDevice:lidTextField.text nickname:nicknameTextField.text dotImageName:dotImageName];
		statusLabel.text = @"saved!";
		[self.navigationController popViewControllerAnimated:YES];
	}
}

- (IBAction) onChangeImage:(id)sender
{
	DotPickerView * dotPickerController = [[[DotPickerView alloc] init] autorelease];
	dotPickerController.delegate = self;
	[dotPickerController setCurrentSelection:dotImageName];
	[self.navigationController pushViewController:dotPickerController animated:YES];
}

// DotPickerDelegate
- (void) DotImagePicked:(NSInteger)imageIndex source:(DotPickerView*)src
{
	NSString * strDotName = [[Resources dotImageNames] objectAtIndex:imageIndex];
	self.dotImageName = [strDotName stringByAppendingString:@".png"];
}

- (void) setDotImageName:(NSString *)theImageName
{
	UIImage * newImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:theImageName ofType:nil]];
	if (newImage != nil)
	{
		dotSampleImage.image = newImage;
		[dotImageName release];
		dotImageName = [theImageName retain];
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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.dotImageName = @"PinkDot.png";
	// save button
	UIBarButtonItem * saveButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)] autorelease];
	self.navigationItem.rightBarButtonItem = saveButton;
}

- (void)viewWillAppear:(BOOL)animated
{
	statusLabel.text = @"Add new device";
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


- (void)dealloc {
	[delegator release];
	[dotImageName release];
    [super dealloc];
}


@end

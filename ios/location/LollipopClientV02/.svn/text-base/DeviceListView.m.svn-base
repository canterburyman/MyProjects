//
//  DeviceListView.m
//  LollpopClientV1
//
//  Created by Xinkai wang on 10/14/10.
//  Copyright 2010 MSFT. All rights reserved.
//

#import "DeviceListView.h"


@implementation DeviceListView

@synthesize rootView;

- (IBAction) add:(id)sender
{
	if (addDeviceViewController == nil)
	{
		addDeviceViewController = [[AddDeviceView alloc] init];
		addDeviceViewController.title = @"New/Edit device";
		addDeviceViewController.delegator = self;
	}
	
	[self.navigationController pushViewController:addDeviceViewController animated:YES];
}

// AddDeviceDelegate
- (void) saveNewDevice:(NSString*)lid nickname:(NSString*)nickname dotImageName:(NSString*)dotImageName 
{
	KidAnnotation * annotation = [[[KidAnnotation alloc] initWithLid:lid] autorelease];
	annotation.subtitle = nickname;
	annotation.dotImageName = dotImageName;
	[rootView addAnnotation:annotation addButton:YES];
	[tableView reloadData];
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

	// edit button
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
	
	// add button
	UIBarButtonItem * addButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add:)] autorelease];
	self.navigationItem.rightBarButtonItem = addButton;
}

- (void)viewWillAppear:(BOOL)animated
{
	NSIndexPath * currentSelection = [tableView indexPathForSelectedRow];
	[tableView deselectRowAtIndexPath:currentSelection animated:YES];
}

#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

/*
 - (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
 {
 return sectionTitles;
 }
 */

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	if (section == 0) {
		return 1;
	}
	else
	{
		return [rootView.annotationArray count] - 1;
	}
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
	KidAnnotation * annotation = nil;
	if (indexPath.section == 0) 
	{
		// self annotation
		annotation = [rootView.annotationArray objectAtIndex:0];
	}
	else
	{
		// kid annotations
		annotation = [rootView.annotationArray objectAtIndex:(indexPath.row+1)];
	}
	
	cell.textLabel.text = annotation.subtitle;
	cell.detailTextLabel.text = annotation.lid;
	cell.imageView.image = annotation.dotImage;
	//cell.showsReorderControl = indexPath.section != 0;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	// Configure the cell.
	
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return indexPath.section != 0;
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
	NSLog(@"move from %@ to %@", fromIndexPath, toIndexPath);
}


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath 
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
	[super setEditing:editing animated:animated];
	[tableView setEditing:editing animated:animated];
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
	if (proposedDestinationIndexPath.section == 0) {
		return [NSIndexPath indexPathForRow:0 inSection:1];
	}
	return proposedDestinationIndexPath;
}

// ******************************** UITableViewDataSource *********************************
// UITableViewDataSource protocol
- (void)tableView:(UITableView *)theTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	assert(theTableView == tableView);
	if (editingStyle == UITableViewCellEditingStyleDelete && indexPath.section == 1) 
	{
		[rootView removeAnnotationByIndex:(indexPath.row + 1) removeButton:YES];
		[tableView reloadData];
    }
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
    [super dealloc];
}


@end

//
//  CoreDataTableViewController.m
//
//  Created for Stanford CS193p Spring 2010
//

#import "CoreDataTableViewController.h"

@implementation CoreDataTableViewController

@synthesize fetchedResultsController;
@synthesize titleKey, subtitleKey, searchKey;

//- (void)createSearchBar
//{
//	if (self.searchKey.length) {
//		if (self.tableView && !self.tableView.tableHeaderView) {
//			UISearchBar *searchBar = [[[UISearchBar alloc] init] autorelease];
//			[[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
//			self.searchDisplayController.searchResultsDelegate = self;
//			self.searchDisplayController.searchResultsDataSource = self;
//			self.searchDisplayController.delegate = self;
//			searchBar.frame = CGRectMake(0, 0, 0, 38);
//			self.tableView.tableHeaderView = searchBar;
//		}
//	} else {
//		self.tableView.tableHeaderView = nil;
//	}
//}

- (void)setSearchKey:(NSString *)aKey
{
	[searchKey release];
	searchKey = [aKey copy];
	//[self createSearchBar];
}

//- (NSString *)titleKey
//{
//	if (!titleKey) {
//		NSArray *sortDescriptors = [self.fetchedResultsController.fetchRequest sortDescriptors];
//		if (sortDescriptors.count) {
//			return [[sortDescriptors objectAtIndex:0] key];
//		} else {
//			return nil;
//		}
//	} else {
//		return titleKey;
//	}
//}

- (void)performFetchForTableView:(UITableView *)tableView
{
	NSError *error = nil;
	[self.fetchedResultsController performFetch:&error];
	if (error) {
		NSLog(@"[CoreDataTableViewController performFetchForTableView:] %@ (%@)", [error localizedDescription], [error localizedFailureReason]);
	}
	//[tableView reloadData];
}

- (NSFetchedResultsController *)fetchedResultsControllerForTableView:(UITableView *)tableView
{
	if (tableView == self.tableView) {
		if (self.fetchedResultsController.fetchRequest.predicate != normalPredicate) {
			[NSFetchedResultsController deleteCacheWithName:self.fetchedResultsController.cacheName];
			self.fetchedResultsController.fetchRequest.predicate = normalPredicate;
			[self performFetchForTableView:tableView];
		}
		[currentSearchText release];
		currentSearchText = nil;
	} else if ((tableView == self.searchDisplayController.searchResultsTableView) && self.searchKey && ![currentSearchText isEqual:self.searchDisplayController.searchBar.text]) {
		[currentSearchText release];
		currentSearchText = [self.searchDisplayController.searchBar.text copy];
		NSString *searchPredicateFormat = [NSString stringWithFormat:@"%@ contains[c] %@", self.searchKey, @"%@"];
		NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:searchPredicateFormat, self.searchDisplayController.searchBar.text];
		[NSFetchedResultsController deleteCacheWithName:self.fetchedResultsController.cacheName];
		self.fetchedResultsController.fetchRequest.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:searchPredicate, normalPredicate , nil]];
		[self performFetchForTableView:tableView];
	}
	return self.fetchedResultsController;
}

//- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
//{
//	// reset the fetch controller for the main (non-searching) table view
//	[self fetchedResultsControllerForTableView:self.tableView];
//}

- (void)setFetchedResultsController:(NSFetchedResultsController *)controller
{
	fetchedResultsController.delegate = nil;
	[fetchedResultsController release];
	fetchedResultsController = [controller retain];
	controller.delegate = self;
//	normalPredicate = [self.fetchedResultsController.fetchRequest.predicate retain];
//	if (!self.title) self.title = controller.fetchRequest.entity.name;
//	if (self.view.window) [self performFetchForTableView:self.tableView];
}

- (UITableViewCellAccessoryType)accessoryTypeForManagedObject:(NSManagedObject *)managedObject
{
	return UITableViewCellAccessoryDisclosureIndicator;
}

- (UIImage *)thumbnailImageForManagedObject:(NSManagedObject *)managedObject
{
	return nil;
}

- (void)configureCell:(UITableViewCell *)cell forManagedObject:(NSManagedObject *)managedObject
{
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForManagedObject:(NSManagedObject *)managedObject
//{
//    static NSString *ReuseIdentifier = @"CoreDataTableViewCell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
//    if (cell == nil) {
//		UITableViewCellStyle cellStyle = self.subtitleKey ? UITableViewCellStyleSubtitle : UITableViewCellStyleDefault;
//        cell = [[[UITableViewCell alloc] initWithStyle:cellStyle reuseIdentifier:ReuseIdentifier] autorelease];
//    }
//	
//	if (self.titleKey) cell.textLabel.text = [managedObject valueForKey:self.titleKey];
//	if (self.subtitleKey) cell.detailTextLabel.text = [managedObject valueForKey:self.subtitleKey];
//	cell.accessoryType = [self accessoryTypeForManagedObject:managedObject];
//	UIImage *thumbnail = [self thumbnailImageForManagedObject:managedObject];
//	if (thumbnail) cell.imageView.image = thumbnail;
//	
//	return cell;
//}

- (void)managedObjectSelected:(NSManagedObject *)managedObject
{
    // Navigation logic may go here. Create and push another view controller.
    // AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
    // [self.navigationController pushViewController:anotherViewController];
    // [anotherViewController release];
}

- (void)deleteManagedObject:(NSManagedObject *)managedObject
{
}

- (BOOL)canDeleteManagedObject:(NSManagedObject *)managedObject
{
	return NO;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
//	NSManagedObject *managedObject = [[self fetchedResultsControllerForTableView:tableView] objectAtIndexPath:indexPath];
//	return [self canDeleteManagedObject:managedObject];
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
//	NSManagedObject *managedObject = [[self fetchedResultsControllerForTableView:tableView] objectAtIndexPath:indexPath];
//	[self deleteManagedObject:managedObject];
}

#pragma mark UIViewController methods

- (void)viewDidLoad
{
	//[self createSearchBar];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self performFetchForTableView:self.tableView];
}

#pragma mark UITableViewDataSource methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
	return nil;
}


//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return [[[self fetchedResultsControllerForTableView:tableView] sections] count];
//}
//
//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//	return [[self fetchedResultsControllerForTableView:tableView] sectionIndexTitles];
//}

#pragma mark UITableViewDelegate methods

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return [[[[self fetchedResultsControllerForTableView:tableView] sections] objectAtIndex:section] numberOfObjects];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{    
//	return [self tableView:tableView cellForManagedObject:[[self fetchedResultsControllerForTableView:tableView] objectAtIndexPath:indexPath]];
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	[self managedObjectSelected:[[self fetchedResultsControllerForTableView:tableView] objectAtIndexPath:indexPath]];
//}
//
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//	return [[[[self fetchedResultsControllerForTableView:tableView] sections] objectAtIndex:section] name];
//}
//
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
//{
//	return [[self fetchedResultsControllerForTableView:tableView] sectionForSectionIndexTitle:title atIndex:index];
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 10, 30)] autorelease];
	return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return 1;
}



#pragma mark NSFetchedResultsControllerDelegate methods

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    NSLog(@"controllerWillChangeContent");
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    NSLog(@"controllerDidChangeContent");
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
		   atIndex:(NSUInteger)sectionIndex
	 forChangeType:(NSFetchedResultsChangeType)type
{	
    NSLog(@"didChangeSection");
}


- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
	   atIndexPath:(NSIndexPath *)indexPath
	 forChangeType:(NSFetchedResultsChangeType)type
	  newIndexPath:(NSIndexPath *)newIndexPath
{	
    NSLog(@"didChangeObject");
}


#pragma mark dealloc

- (void)dealloc
{
	fetchedResultsController.delegate = nil;
	[fetchedResultsController release];
	[searchKey release];
	[titleKey release];
	[currentSearchText release];
	[normalPredicate release];
    [super dealloc];
}

@end


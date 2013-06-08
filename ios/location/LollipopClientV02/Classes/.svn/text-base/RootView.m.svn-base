    //
//  RootView.m
//  LollipopClientV02
//
//  Created by Xinkai wang on 10/16/10.
//  Copyright 2010 MSFT. All rights reserved.
//

#import "RootView.h"
#import "DeviceListView.h"
#import "KidAnnotationView.h"

@implementation RootView

@synthesize currentSelection;
@synthesize annotationArray;


// ******************************** AnnotationList *********************************
- (RootView*) init
{
	self = [super init];
	annotationArray = [[NSMutableArray arrayWithCapacity:4] retain];
	annotationDict = [[NSMutableDictionary dictionaryWithCapacity:4] retain];
	currentSelection = -1;
	return self;
}

// annotation array
- (void) addAnnotation:(KidAnnotation*)annotation addButton:(Boolean)addButton
{
	assert(annotation != nil);
	[annotationArray addObject:annotation];
	[annotationDict setObject:annotation forKey:annotation.lid];

	// add button
	if (addButton) 
	{
		[self addAnnotationButton:annotation];
	}
	
	if (!annotation.fIsSelfAnnotation) // do following only when this is a normal kids annotation. (not a self annotation)
	{
		// add annotation into MapView
		if (!annotation.fInMapView)
		{
			[mapView addAnnotation:annotation];
		}
		
		// subscribe to the updates of this device
		[transport retquestLocation:annotation.lid];
	}
	
}

- (void) addAnnotationButton:(KidAnnotation *)annotation
{
	// we assume the annotation.dotImage has already loaded.
	UIButton * buttonView = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[buttonView setImage:annotation.dotImage forState:UIControlStateNormal];
	CGRect rect;
	rect.size.height = 40.;
	rect.size.width = 50.;
	buttonView.frame = rect;
	//UIEdgeInsets edge = UIEdgeInsetsMake(5.,20.,5.,20.);
	//buttonView.contentEdgeInsets = edge;
	UIBarButtonItem * barButton = [[[UIBarButtonItem alloc] initWithCustomView:buttonView] autorelease];
	[buttonView addTarget:self action:@selector(dotButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
	//buttonView.target = self;
	//buttonView.action = @selector(dotButtonClicked);
	//buttonView.backgroundColor = [UIColor redColor];
	NSMutableArray *items = [NSMutableArray arrayWithArray:toolBar.items];
	//[items addObject:barButton];
	if ([annotation.lid isEqual:@"self"]) 
	{
		[items insertObject:barButton atIndex:0];
	}
	else 
	{
		[items addObject:barButton];
	}

	//toolBar.items = items;
	[toolBar setItems:items animated:NO];
	
	annotation.toolBarButton = buttonView;
	[self saveAnnotationsList];
}

- (void) removeAnnotationButtonByIndex:(NSInteger)index
{
	NSMutableArray *items = [NSMutableArray arrayWithArray:toolBar.items];
	[items removeObjectAtIndex:(index + 4)]; // we always have 5 items in this array before kid annotation buttons 1)self, 2)left space, 3)mapType 4)add button 5) right space
	[toolBar setItems:items animated:YES];
}

- (void) removeAnnotationByIndex:(NSInteger)index removeButton:(Boolean)removeButton;
{
	NSLog(@"removeAnnotation");
	KidAnnotation * annotation = [[self findAnnotationByIndex:index] retain];
	if (annotation != nil) 
	{
		if (removeButton) 
		{
			[self removeAnnotationButtonByIndex:index];
		}
		[annotationArray removeObjectAtIndex:index];
		[annotationDict removeObjectForKey:annotation.lid];
		[mapView removeAnnotation:annotation];
		if (annotation.isCenterOnThis) 
		{
			self.currentSelection = 0;
		}
		[annotation release];
		[self saveAnnotationsList];
	}
}

- (KidAnnotation*)findAnnotationByLid:(NSString*)theLid
{
	return [annotationDict objectForKey:theLid];
}


- (KidAnnotation*) findAnnotationByIndex:(NSInteger)index
{
	if (index == -1 || index >= annotationArray.count) 
	{
		return nil;
	}
	return [annotationArray objectAtIndex:index];
}

- (int) findAnnotationIndexByButton:(UIButton*)sender
{
	for (int i=0; i<annotationArray.count; i++) 
	{
		KidAnnotation * annotation = [annotationArray objectAtIndex:i];
		if (annotation.toolBarButton == sender) 
		{
			return i;
		}
	}
	return -1;
}

// load annotation list based on the saved user defaults. If no saved setting, use default.
- (void) initAnnotationsList
{
	// init/load annotation list
	NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
	NSArray * annoList = [userDefaults objectForKey:@"arrAnnotationList"];
	if (annoList != nil)
	{
		for (NSDictionary * dict in annoList)
		{
			NSString * lid = [dict objectForKey:@"strLid"];
			if([lid length] != 0)
			{
				KidAnnotation * annotation = [[KidAnnotation alloc] initWithLid:lid];
				NSString * nickName = [dict objectForKey:@"strNickname"];
				if ([nickName length] != 0)
				{
					annotation.subtitle = nickName;
				}
				NSString * dotImageName = [dict objectForKey:@"strDotImageName"];
				if ([dotImageName length] != 0)
				{
					annotation.dotImageName = dotImageName;
				}
				[self addAnnotation:annotation addButton:YES];
			}
		}
	}
	else 
	{
		// by default, only add self annotation
		KidAnnotation * annotation = [[[KidAnnotation alloc] initWithLid:@"self"] autorelease];
		annotation.dotImageName = @"BlueDot.png";
		[self addAnnotation:annotation addButton:YES];
	}
	
}

- (void) saveAnnotationsList
{
	NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
	NSMutableArray * annoList = [NSMutableArray arrayWithCapacity:5];
	// add all the annotations in the list
	for (KidAnnotation * item in annotationArray)
	{
		NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithCapacity:4];
		// lid
		[dict setObject:item.lid forKey:@"strLid"];
		// nickname
		if (item.subtitle != nil && [item.subtitle length] != 0) 
		{
			[dict setObject:item.subtitle forKey:@"strNickname"];
		}
		// dotimage
		if (item.dotImageName != nil && [item.dotImageName length] != 0) 
		{
			[dict setObject:item.dotImageName forKey:@"strDotImageName"];
		}
		[annoList addObject:dict];
	}
	[userDefaults setObject:annoList forKey: @"arrAnnotationList"];
}

- (void) saveCurrentSelection
{
	NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
	// save current selection index (which annotation is set centering on)
	[userDefaults setObject:[NSNumber numberWithInt:currentSelection] forKey:@"intCurrentSelection"];
	// save current selected map type (0=map or 1=hibird)
	[userDefaults setInteger:mapTypeControl.selectedSegmentIndex forKey:@"intMapType"];
}

// return true means loaded successfuly
- (Boolean) loadCurrentSelection:(NSInteger*)theSelection
{
	NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
	NSNumber * val = [userDefaults objectForKey:@"intCurrentSelection"];
	if (val != nil) 
	{
		*theSelection = [val intValue];
		return YES;
	}
	return NO;
}

- (void) saveCurrentMapType
{
	NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
	// save current selected map type (0=map or 1=hibird)
	[userDefaults setInteger:mapTypeControl.selectedSegmentIndex forKey:@"intMapType"];
}

- (void) initMapType
{
	NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
	mapTypeControl.selectedSegmentIndex = [userDefaults integerForKey:@"intMapType"];
}

- (void) saveCurrentRegion
{
	NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
	// save current zoom level (next load up will show to the same zoom level and center location)
	MKCoordinateRegion region = mapView.region;
	NSMutableArray * array = [NSMutableArray arrayWithCapacity:4];
	[array addObject:[NSNumber numberWithDouble:region.center.latitude]];
	[array addObject:[NSNumber numberWithDouble:region.center.longitude]];
	[array addObject:[NSNumber numberWithDouble:region.span.latitudeDelta]];
	[array addObject:[NSNumber numberWithDouble:region.span.longitudeDelta]];
	[userDefaults setObject:array forKey:@"regCurrentRegion"];
}

// return true means loaded successfuly
- (Boolean) loadCurrentRegion:(MKCoordinateRegion*)theRegion
{
	NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
	NSArray * array = [userDefaults objectForKey:@"regCurrentRegion"];
	if (array != nil) 
	{
		theRegion->center.latitude = [[array objectAtIndex:0] doubleValue];
		theRegion->center.longitude = [[array objectAtIndex:1] doubleValue];
		theRegion->span.latitudeDelta = [[array objectAtIndex:2] doubleValue];
		theRegion->span.longitudeDelta = [[array objectAtIndex:3] doubleValue];
		return YES;
	}
	return NO;
}

// ******************************** dotButtonClicked *********************************
- (IBAction) dotButtonClicked:(id)sender
{
	NSLog(@"Controller::dotButtonClicked()");
	NSInteger index = [self findAnnotationIndexByButton:sender];
	
	if (index != currentSelection) 
	{
		self.currentSelection = index;
	}
}

- (void) setCurrentSelection:(NSInteger)index
{
	KidAnnotation * oldAnnotation = [self findAnnotationByIndex:currentSelection];
	oldAnnotation.isCenterOnThis = NO;
	
	currentSelection = index;
	KidAnnotation * newAnnotation = [self findAnnotationByIndex:currentSelection];
	if (newAnnotation != nil) 
	{
		newAnnotation.isCenterOnThis = YES;
		[self updateMapCenter];
	}
}

- (void)updateMapCenter
{
	KidAnnotation * annotation = [self findAnnotationByIndex:currentSelection];
	assert(annotation != nil);
	if (annotation && (annotation.coordinate.latitude != 0.0 || annotation.coordinate.longitude != 0.0)) 
	{
		if (fFirstCenteredMap == NO) 
		{
			// if this is the first time centering the map, we also want to zoom in to detail enough house/tree view level.
			MKCoordinateRegion region;
			region.center = annotation.coordinate;
			region.span.latitudeDelta = 0.003;
			region.span.longitudeDelta = 0.003;
			fFirstCenteredMap = YES;
			mapView.region = region;
		}
		else 
		{
			// if this is not the first centering, we just center, don't touch zoom.
			mapView.centerCoordinate = annotation.coordinate;
		}
	}
}

- (void)segmentAction:(UISegmentedControl*)sender
{
	NSLog(@"segmentAction");
	NSInteger nType = mapTypeControl.selectedSegmentIndex;
	mapView.mapType = nType==0?MKMapTypeStandard:MKMapTypeHybrid;
}

// button action
- (IBAction) onAddButtonClicked:(id)sender
{
	NSLog(@"RootView::onAddButtonClicked()");
	if (popoverController == nil)
	{
		DeviceListView * devicesViewController = [[[DeviceListView alloc] init] autorelease];
		devicesViewController.title = @"Device List";
		devicesViewController.rootView = self;
		navController = [[UINavigationController alloc] initWithRootViewController:devicesViewController];
		popoverController = [[UIPopoverController alloc] initWithContentViewController:navController];
	}
	else 
	{
		[navController popToRootViewControllerAnimated:NO];
	}
	[popoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}


// ******************************** Location Manager *********************************

// Return a location manager -- create one if necessary.
- (CLLocationManager *)locationManager {
    
    if (locationManager != nil) {
        return locationManager;
    }
    
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager setDelegate:self];
    
    return locationManager;
}

// CLLocationManagerDelegate Protocol
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	NSString * log = [NSString stringWithFormat:@"Location Updated: new location = %@", newLocation];
	NSLog(log, nil);
	
	/*
	 if (fCenterOnSelfLocation) {
	 MKCoordinateRegion region;
	 region.center = newLocation.coordinate;
	 region.span.latitudeDelta = 0.003;
	 region.span.longitudeDelta = 0.003;
	 mapView.region = region;
	 }
	 */
	KidAnnotation * annotation = [self findAnnotationByLid:@"self"];
	LocationReport report;
	report.cor = newLocation.coordinate;
	report.acc = newLocation.horizontalAccuracy;
	NSDate * date = [NSDate date];
	NSTimeInterval interval = [date timeIntervalSince1970];
	report.timestamp = (int)(interval * 10. + 0.5);
	[annotation setNewLocation:&report];
	if (annotation.isCenterOnThis) 
	{
		[self updateMapCenter];
	}
	
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	NSString* log = [NSString stringWithFormat:@"Location didFailWithError: new location = %@", error];
	NSLog(log, nil);
}

// ******************************** TransportLayer *********************************
- (void) onTimeOut
{
	NSLog(@"onTimeOut", nil);
	for (KidAnnotation * annotation in annotationArray) 
	{
		if (!annotation.fIsSelfAnnotation) 
		{
			[transport retquestLocation:annotation.lid];
		}
	}
	//[transport retquestLocation:@"1(425)458-8776"];
}

// TransportLayerDelegate Protocol
- (void) didUpdateToLocation:(LocationReport*)newLocation lid:(NSString*)lid 
{
	//DummyMKAnnotation * annotation = [[DummyMKAnnotation alloc] initWithCoordinateAndTitles:newLocation subtitle:lid title:@"title"];
	//[mapView addAnnotation:annotation];
	//[annotation release];
	
	
	// find the annocation
	KidAnnotation * annotation = [self findAnnotationByLid:lid];
	if (annotation == nil)
	{
		assert(NO); // how come unknown lid?
		// unknown lid, so do nothing
		/*
		 KidAnnotation * annotation = [[KidAnnotation alloc] initWithLocation:newLocation lid:lid];
		 [self addAnnotation:annotation];
		 [annotation release];
		 */
	}
	else // when this lid already exist as annotation, we need to update the location
	{
		[annotation setNewLocation:newLocation];
		// add annotation into mapview when currently not there yet
		if (annotation.fInMapView == NO) 
		{
			[mapView addAnnotation:annotation];
			annotation.fInMapView = YES;
		}
	}
	
	if (annotation.isCenterOnThis)
		[self updateMapCenter];
}

// ******************************** MKMapView *********************************
// MKMapViewDelegate Protocol
- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
	// use default annotation view for the unknown types of annotations.
	if (![annotation isKindOfClass:KidAnnotation.class])
	{
		return nil;
	}
	
	// try to get a instance of KidAnnotationView from reuseable pool
	NSString * identitier = [KidAnnotationView identifier];
	MKAnnotationView * view = [theMapView dequeueReusableAnnotationViewWithIdentifier:identitier];
	if (view == nil)
	{
		view = [[[KidAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identitier] autorelease];
	}
	return view;
}

// return CGSize in meters
+ (CGSize)calculateSizeFromCoordinateRegion:(MKCoordinateRegion) region
{
	CGSize size;
	double deg2rad = M_PI/180.;
	double R = 20000000/M_PI; // 40000Km/(2*Pi)
	double r = R * cos(region.center.latitude * deg2rad);
	size.height = R * (region.span.latitudeDelta * deg2rad);
	size.width = r * (region.span.longitudeDelta * deg2rad);
	return size;
}

- (Boolean) IsCenterStillWithin:(Float32)threshold // threshold is float, in persentade. (exp, 20.0 means 20% of total viewable area)
{
	KidAnnotation * annotation = [self findAnnotationByIndex:currentSelection];
	MKCoordinateRegion region = mapView.region;
	if (annotation == nil || region.span.latitudeDelta == 0 || region.span.longitudeDelta == 0) 
	{
		return NO;
	}
	double diff = region.center.latitude - annotation.coordinate.latitude;
	diff = (diff > 0)?diff:-diff;
	if (diff/region.span.latitudeDelta > threshold*0.01) 
	{
		return NO;
	}
	diff = region.center.longitude - annotation.coordinate.longitude;
	diff = (diff > 0)?diff:-diff;
	if (diff/region.span.longitudeDelta > threshold*0.01) 
	{
		return NO;
	}
	return YES;
}

// MKMapViewDelegate Protocol
- (void)mapView:(MKMapView *)theMapView regionDidChangeAnimated:(BOOL)animated
{
	assert(mapView == theMapView);
	if (currentSelection >= 0 && ![self IsCenterStillWithin:15]) 
	{
		self.currentSelection = -1;
	}
	[self updateMapScaleFactor];
}

// MKMapViewDelegate Protocol
- (void)mapView:(MKMapView *)theMapView regionWillChangeAnimated:(BOOL)animated
{
	assert(mapView == theMapView);
	[self updateMapScaleFactor];
}

// MKMapViewDelegate Protocol
- (void)mapViewDidFinishLoadingMap:(MKMapView *)theMapView
{
	assert(mapView == theMapView);
	[self updateMapScaleFactor];
}

- (void) updateMapScaleFactor
{
	// area size in meters
	CGSize areaSize = [RootView calculateSizeFromCoordinateRegion:mapView.region];
	
	// current view size in pixels
	CGSize viewSize = [mapView frame].size;
	float rato = 4.; // default value 4 pixel/meter
	if (areaSize.width != 0. && areaSize.height != 0.) 
	{
		rato = (viewSize.height/areaSize.height + viewSize.width/areaSize.width)/2.;
	}
	// update all the existing annotations
	for (id annotation in annotationArray) 
	{
		[annotation setMapScaleFactor:[NSNumber numberWithFloat:rato]];
	}
}

// ******************************** UIViewController *********************************

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
	self.view.frame = [[UIScreen mainScreen] applicationFrame];
	// this will load annotation list and add the annotation buttons in toolbar
	[self initAnnotationsList];
	[self initZoomLevel];
	[self initMapType];
	[self startApp];
}

- (void) initZoomLevel
{
	MKCoordinateRegion region;
	Boolean ret = [self loadCurrentRegion:&region];
	if (ret) 
	{
		mapView.region = region;
		fFirstCenteredMap = YES;
	}
	
	NSInteger nSelection = 0; 
	ret = [self loadCurrentSelection:&nSelection];
	if (nSelection != -1)
	{
		self.currentSelection = nSelection;
	}
}

-(void) startApp
{
	// note: annotationArray and annotationDict created in init(), not here.
	
	// mapView
	mapView.showsUserLocation = YES;
	mapView.delegate = self; // MKMapViewDelegate
	[self.locationManager startUpdatingLocation];
	
	// Transport layer
	transport = [[TransportLayer alloc] init];
	transport.hostNamePortPath = @"http://maggie618.dyndns.org:8080/MyTest/query?";
	transport.delegate = self; // TransportLayerDelegate
	
	// start Timer
	myTimer = [NSTimer scheduledTimerWithTimeInterval:3 
											   target:self 
											 selector:@selector(onTimeOut) 
											 userInfo:nil 
											  repeats:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


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
	[annotationArray release];
	[annotationDict release];
	
	[navController release];
	[locationManager release];
    [super dealloc];
}


@end

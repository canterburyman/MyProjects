//
//  RootView.h
//  LollipopClientV02
//
//  Created by Xinkai wang on 10/16/10.
//  Copyright 2010 MSFT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "TransportLayer.h"
#import "KidAnnotation.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocation.h>


@interface RootView : UIViewController<CLLocationManagerDelegate, MKMapViewDelegate, TransportLayerDelegate> {
	IBOutlet MKMapView * mapView;
	IBOutlet UIBarButtonItem * buttonAdd;
	IBOutlet UIToolbar * toolBar;
	IBOutlet UISegmentedControl * mapTypeControl;

	UINavigationController * navController;
	UIPopoverController * popoverController;

	// receive location update and data from locationManager and transport layer
	CLLocationManager * locationManager;
	TransportLayer * transport;
	
	// array of KidAnnotation.
	// self annotation is named "self"
	NSMutableArray * annotationArray; //first one is always self location. annotationArray and annotationDict is redundent, just for fast access.
	NSMutableDictionary * annotationDict; // key:(NSString*)lid, value:(DummyMKAnnotation*)annotation
	
	NSTimer * myTimer;
	
	//CLLocationCoordinate2D selfLocation;
	//CLLocationCoordinate2D kidLocation;
	
	NSInteger currentSelection; // -1 means none selected; 0 means self button is selected; 1 means first kid
	Boolean fFirstCenteredMap;
}

@property (nonatomic) NSInteger currentSelection;
@property (nonatomic, readonly) NSArray * annotationArray;

// ******************************** AnnotationList *********************************
// button action
- (IBAction) onAddButtonClicked:(id)sender;

- (void) initAnnotationsList;

- (void) addAnnotation:(KidAnnotation*)annotation addButton:(Boolean)addButton;

- (void) addAnnotationButton:(KidAnnotation *)annotation;

- (void) removeAnnotationByIndex:(NSInteger)index removeButton:(Boolean)removeButton;

- (KidAnnotation*) findAnnotationByIndex:(NSInteger)index;

- (void) saveAnnotationsList;
- (void) saveCurrentSelection;
- (void) saveCurrentMapType;
- (void) saveCurrentRegion;

// ******************************** dotButtonClicked *********************************
// button action
- (IBAction) onAddButtonClicked:(id)sender;

- (void) setCurrentSelection:(NSInteger)index;

- (void) updateMapCenter;

- (IBAction) segmentAction:(id)sender;

// ******************************** Location Manager *********************************
- (CLLocationManager *)locationManager;
// CLLocationManagerDelegate Protocol
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation;
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;

- (void)updateMapCenter;

// ******************************** TransportLayer *********************************
- (void) onTimeOut;

// TransportLayerDelegate Protocol
- (void) didUpdateToLocation:(LocationReport*)newLocation lid:(NSString*)lid;

// ******************************** MKMapView *********************************
// MKMapViewDelegate Protocol
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation;

// MKMapViewDelegate Protocol
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated;
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated;

// MKMapViewDelegate Protocol
- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView;

// helper function
- (void) updateMapScaleFactor;

// return CGSize in meters
+ (CGSize)calculateSizeFromCoordinateRegion:(MKCoordinateRegion) region;


// ******************************** UIViewController *********************************

- (void) initZoomLevel;

- (void) startApp;

@end

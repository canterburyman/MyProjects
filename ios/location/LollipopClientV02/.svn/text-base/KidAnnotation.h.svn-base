//
//  KidAnnotation.h
//  LollpopClientV1
//
//  Created by Xinkai wang on 9/28/10.
//  Copyright 2010 MSFT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

#import "LocationReport.h"
#import "KidAnnotationDelegate.h"

@interface KidAnnotation : NSObject<MKAnnotation> {
	NSString * lid; // lid should not have "," in it.
	NSString * subtitle;
	NSString * dotImageName; // default is "BlueDot.png"

	CLLocationCoordinate2D coordinate;
	CLLocationDistance altitude;
	CLLocationAccuracy horizontalAccuracy;
	CLLocationAccuracy verticalAccuracyl;
	CLLocationSpeed speed;
	long long timestamp;
	
	id<KidAnnotationDelegate> listener; // normally it's (KidAnnocationView *)
	
	// dot image
	UIImage * dotImage;
	
	// buttons
	UIButton * toolBarButton; // the pink dot button
	
	// status
	Boolean fInMapView; // set to true when this annotation has already added into the MapView object.
	Boolean isCenterOnThis; // true when Controller::currentSelection is pointing to this annotation.

	Boolean fIsSelfAnnotation; // true when lid == self
	Boolean fLocationKnown; // true only when the coordinate location is already known in this annotation. Normally when this is false, we don't want to show this annotation in MapView.
	Boolean fLocationIsFresh; // true only when the coordinate location is recent enough (say, within 20 seconds).
}

@property (nonatomic, readonly) NSString * lid;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSString * dotImageName;

@property (nonatomic, readonly) UIImage * dotImage;

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic) CLLocationDistance altitude;
@property (nonatomic) CLLocationAccuracy horizontalAccuracy;
@property (nonatomic) CLLocationAccuracy verticalAccuracyl;
@property (nonatomic) CLLocationSpeed speed;
@property (nonatomic) long long timestamp;

@property (nonatomic, retain) id<KidAnnotationDelegate> listener;
@property (nonatomic, retain) UIButton * toolBarButton;
@property (nonatomic) Boolean fInMapView; // whether this annotation is added into mapview.
@property (nonatomic) Boolean isCenterOnThis; // whether this annotation is currently tracing as center.

@property (nonatomic, readonly) Boolean fIsSelfAnnotation;
@property (nonatomic, readonly) Boolean fLocationKnown;
@property (nonatomic, readonly) Boolean fLocationIsFresh;

- (KidAnnotation*) initWithLid:(NSString *)lid;
- (KidAnnotation*) initWithLocation:(LocationReport*)location lid:(NSString *)lid;

- (void) setNewLocation:(LocationReport*)location;
- (void) setMapScaleFactor:(NSNumber*)newMapScaleFactor; //pixlesPerMeter

- (NSString *)title;
- (NSString *)subtitle;
- (CGSize) accDisplaySize;

- (void) setIsCenterOnThis:(Boolean)centerOnThis;

- (void) dealloc;
@end

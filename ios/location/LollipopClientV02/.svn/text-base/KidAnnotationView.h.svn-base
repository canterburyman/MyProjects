//
//  KidAnnotationView.h
//  LollpopClientV1
//
//  Created by Xinkai wang on 9/28/10.
//  Copyright 2010 MSFT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "KidAnnotation.h"
#import "KidAnnotationDelegate.h"


@interface KidAnnotationView : MKAnnotationView<KidAnnotationDelegate> {
	UIView * accView;
	UIView * dotView;
	UIView * rippleView;
	
	float mapScaleFactor; //pixlesPerMeter
}

+ (NSString*) identifier; 

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier;

- (void) startRippleAnimation;

- (void) setAccDisplaySize:(CGSize)size animated:(Boolean)animated;

//- (void) drawRect:(CGRect)rect;

// KidAnnotationDelegate
// KidAnnotation::setNewLocation calls this to notify us the location has been updated.
- (void) locationUpdated:(KidAnnotation*)source;
- (void) setMapScaleFactor:(NSNumber*)mapScaleFactor; //pixlesPerMeter

- (void) updateAccDisplaySize:(Boolean)isAnimated;

@end

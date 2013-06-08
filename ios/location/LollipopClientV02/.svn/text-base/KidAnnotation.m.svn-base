//
//  KidAnnotation.m
//  LollpopClientV1
//
//  Created by Xinkai wang on 9/28/10.
//  Copyright 2010 MSFT. All rights reserved.
//

#import "KidAnnotation.h"


@implementation KidAnnotation

@synthesize lid, subtitle, dotImageName, dotImage;
@synthesize coordinate, altitude, horizontalAccuracy, verticalAccuracyl, speed, timestamp;
@synthesize listener, toolBarButton;
@synthesize fInMapView, isCenterOnThis;
@synthesize fIsSelfAnnotation, fLocationKnown;

- (KidAnnotation*) initWithLid:(NSString *)theLid
{
	self = [super init];
	lid = [theLid retain];
	fIsSelfAnnotation = [lid isEqual:@"self"];
	return self;
}

- (KidAnnotation*) initWithLocation:(LocationReport*)location lid:(NSString *)theLid;
{
	self = [super init];
	lid = [theLid retain];
	coordinate = location->cor;
	horizontalAccuracy = location->acc;
	timestamp = location->timestamp;
	return self;
}

- (Boolean) fLocationIsFresh
{
	if (fLocationKnown)
	{
		long long timeDiff = timestamp - (long long)([[NSDate date] timeIntervalSince1970]*10. + 0.5);
		return timeDiff <= 200; // <= 20 seconds
	}
	return NO;
}

- (void) setNewLocation:(LocationReport*)location
{
	if (location == nil)
		return;
	
	self.coordinate = location->cor; // note: must use self.coordinate instead of coordinate, MapKit can get notified.
	horizontalAccuracy = location->acc;
	if (timestamp != location->timestamp) 
	{
		timestamp = location->timestamp;
		//SEL selLocationUpdated = @selector(locationUpdated:); // - (void)locationUpdated:(KidAnnotation*)source
		if (listener != nil) 
		{
			[listener locationUpdated:self];
		}
	}
}

- (void) setMapScaleFactor:(NSNumber*)newMapScaleFactor //pixlesPerMeter
{
	//SEL selScaleFactor = @selector(setMapScaleFactor:); // - (void)setMapScaleFactor:(NSNumber*)newMapScaleFactor;
	if (listener != nil) 
	{
		[listener setMapScaleFactor:newMapScaleFactor];
	}
}

- (NSString *)subtitle
{
	return subtitle;
	//return [NSString stringWithFormat:@"%.8f, %.8f", coordinate.latitude, coordinate.longitude];
}

- (void)setDotImageName:(NSString *)dotName
{
	dotImageName = [dotName retain];
	dotImage = [[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:dotImageName ofType:nil]] retain];

	if (dotImage == nil) // if the specified dot image could not load, use the default one.
	{
		dotImageName = @"BlueDot.png";
		dotImage = [[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:dotImageName ofType:nil]] retain];
	}
}

- (NSString *)title
{
	return lid;
}

- (CGSize) accDisplaySize
{
	CGSize size;
	// should set size based on horizontalAccuracy
	size.height = 100;
	size.width = 100;
	return size;
}

- (void) setIsCenterOnThis:(Boolean)newIsCenterOnThis
{
	isCenterOnThis = newIsCenterOnThis;
	UIImage * blueLocaterImage = nil;
	if (isCenterOnThis)
	{
		blueLocaterImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"LocateBlue.png" ofType:nil]];
	}
	[toolBarButton setBackgroundImage:blueLocaterImage forState:UIControlStateNormal];
}

- (void) dealloc
{
	[lid release];
	[subtitle release];
	[dotImageName release];
	[dotImage release];
	
	[toolBarButton release];
	//[listener release];
	[super dealloc];
}
@end

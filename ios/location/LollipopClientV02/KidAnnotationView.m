//
//  KidAnnotationView.m
//  LollpopClientV1
//
//  Created by Xinkai wang on 9/28/10.
//  Copyright 2010 MSFT. All rights reserved.
//

#import "KidAnnotationView.h"
#import "KidAnnotation.h"

@implementation KidAnnotationView

static NSString * strIdentifier = @"KidAnnotationView";

+ (NSString*) identifier
{
	return strIdentifier;
}

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
	assert([annotation isKindOfClass:KidAnnotation.class]);

	KidAnnotation * kid = nil;
	if ([annotation isKindOfClass:KidAnnotation.class]) {
		kid = (KidAnnotation*)annotation;
		kid.listener = self;
	}
	
	self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
	NSLog(@"KidAnnotationView::initWithAnnotation() annotation = %@, reuseIdentifier = %s", annotation, reuseIdentifier);
	
	// set size of this Annotation view
	/*
	CGRect rect;
	rect.size.height = 100.;
	rect.size.width = 100.;
	rect.origin = self.frame.origin;
	self.frame = rect;
	*/

	// set self as the listener of the annotation.

	// accuration circle
	UIImage * accImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"BlueArea200x200.png" ofType:nil]];
	accView = [[UIImageView alloc] initWithImage:accImage];
	[self addSubview:accView];
	CGPoint centerInBounds;
	//centerInBounds.x = self.bounds.size.width/2.;
	//centerInBounds.y = self.bounds.size.height/2.;
	accView.center = centerInBounds;
	CGRect rect;
	rect.size = [((KidAnnotation*)annotation) accDisplaySize];
	accView.bounds = rect;
	
	// ripple circle
	UIImage * rippleImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"BlueArea200x200.png" ofType:nil]];
	rippleView = [[UIImageView alloc] initWithImage:rippleImage];
	[self addSubview:rippleView];
	rippleView.center = centerInBounds;
	rippleView.alpha = 0.;
	rect.size.height = 0.;
	rect.size.width = 0.;
	rippleView.bounds = rect;

	// dot image
	//UIImage * dotImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PinkDot.png" ofType:nil]];
	dotView = [[UIImageView alloc] initWithImage:kid.dotImage];
	[self addSubview:dotView];
	dotView.center = centerInBounds;
	
	return self;
}

- (void) startRippleAnimation
{
	// set start
	rippleView.alpha = 1.;
	CGRect rect;
	rect.size.height = 10.;
	rect.size.width = 10.;
	rippleView.bounds = rect;
	
	// annimation for ripple
	[UIView beginAnimations:@"rippleAnimation" context:nil];
	[UIView setAnimationDuration:2.];
	rippleView.alpha = 0.;
	rect.size.height = 400.;
	rect.size.width = 400.;
	rippleView.bounds = rect;
	[UIView commitAnimations];
}

- (void) setAccDisplaySize:(CGSize)size animated:(Boolean)animated
{
	CGRect rect;
	rect.size = size;

	if (animated)
	{
		[UIView beginAnimations:@"accSizeAnimation" context:nil];
		[UIView setAnimationDuration:0.7];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
		accView.bounds = rect;
		[UIView commitAnimations];
	}
	else 
	{
		accView.bounds = rect;
	}
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect 
{
    // Drawing code
	//NSLog(@"drawRect: frame = %@, bounds = %@", self.frame, self.bounds);
	[super drawRect:rect];
	
	//CGContextRef context = UIGraphicsGetCurrentContext();
	//[[UIColor grayColor] set];
	//UIRectFill ([self bounds]);
}
*/

// KidAnnotationDelegate
- (void)locationUpdated:(KidAnnotation*)source
{
	if (source != self.annotation) 
	{
		// this view has been detached or reused, looks like it's not associated with old KidAnnotation anymore.
		NSLog(@"WARNING! KidAnnotationView::locationUpdated() is called by a source which is different from current annotation!, source=%@, annocation=%@", source, self.annotation);
		source.listener = nil;
	}
	else
	{
		// show ripple ring annimation and update area circle
		[self startRippleAnimation];
		[self updateAccDisplaySize:YES];
	}
}

- (void) setMapScaleFactor:(NSNumber*)newMapScaleFactor //pixlesPerMeter
{
	if (newMapScaleFactor.floatValue != mapScaleFactor) 
	{
		mapScaleFactor = newMapScaleFactor.floatValue;
		[self updateAccDisplaySize:NO];
	}
}

// KidAnnotationDelegate
- (void) updateAccDisplaySize:(Boolean)isAnimated
{
	if ([self.annotation isKindOfClass:KidAnnotation.class])
	{
		KidAnnotation * kid = (KidAnnotation*)(self.annotation);
		CLLocationAccuracy horizontalAccuracy = 0;
		horizontalAccuracy = [kid horizontalAccuracy];
		CGSize size;
		size.height = size.width = horizontalAccuracy*mapScaleFactor*2;
		[self setAccDisplaySize:size animated:isAnimated];
	}
}

- (void)dealloc {
	[accView release];
	[dotView release];
	[rippleView release];
    [super dealloc];
}


@end

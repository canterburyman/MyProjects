//
//  TransportLayerDelegate.h
//  LollpopClientV1
//
//  Created by Xinkai wang on 9/6/10.
//  Copyright 2010 MSFT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LocationReport.h"

@protocol TransportLayerDelegate <NSObject>

@optional
- (void) didUpdateToLocation:(LocationReport*)newLocation lid:(NSString*)lid ;

@end


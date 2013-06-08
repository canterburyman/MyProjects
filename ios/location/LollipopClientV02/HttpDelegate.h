//
//  HttpDelegate.h
//  MVCView
//
//  Created by Xinkai wang on 9/27/10.
//  Copyright 2010 MSFT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HttpConnection;

@protocol HttpDelegate

- (void) HttpResponseArrived:(NSString*)content source:(HttpConnection*)src;

@end

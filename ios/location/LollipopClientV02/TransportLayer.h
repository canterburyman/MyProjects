//
//  TransportLayer.h
//  LollpopClientV1
//
//  Created by Xinkai wang on 9/6/10.
//  Copyright 2010 MSFT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TransportLayerDelegate.h"
#import "HttpConnection.h"
#import "LocationReport.h"


@interface TransportLayer : NSObject<HttpDelegate> {
	NSString * hostNamePortPath; // @"http://maggie618.dyndns.org:8080/MyTest/query?"
	id<TransportLayerDelegate> delegate;
	
}

@property (copy) NSString * hostNamePortPath;

- (void) setDelegate:(id<TransportLayerDelegate>)delegate;

- (void) retquestLocation:(NSString*)lid; // normally call this every 5 seconds to get constant update.

// HttpDelegate Protocol
- (void) HttpResponseArrived:(NSString*)content source:(HttpConnection*)src;

+ (BOOL) parseLocation:(NSString *)content 
				   lid:(NSString**)pLid
		location:(LocationReport*)location;

@end



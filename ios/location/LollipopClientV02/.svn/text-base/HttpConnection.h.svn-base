//
//  HttpConnection.h
//  MVCView
//
//  Created by Xinkai wang on 9/27/10.
//  Copyright 2010 MSFT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpDelegate.h"


@interface HttpConnection : NSObject {
	NSURLConnection *connection;
	
	NSInteger statusCode;
	NSMutableData * data;
	id<HttpDelegate> delegate; // - (void) HttpResponseArrived:(NSString*)content source:(HttpConnection*)src;
}

@property NSInteger statusCode;
@property (readonly) NSMutableData * data;
@property (readonly) NSURLConnection *connection;
@property (readonly) id<HttpDelegate> delegate;

- (HttpConnection*) initWithURLConnection:(NSURLConnection*)connection delegate:(id<HttpDelegate>)theDelegate;
@end

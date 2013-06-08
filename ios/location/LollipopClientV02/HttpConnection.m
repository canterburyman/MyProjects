//
//  HttpConnection.m
//  MVCView
//
//  Created by Xinkai wang on 9/27/10.
//  Copyright 2010 MSFT. All rights reserved.
//

#import "HttpConnection.h"


@implementation HttpConnection

@synthesize statusCode, data, connection, delegate;

- (HttpConnection*) initWithURLConnection:(NSURLConnection*)theConnection delegate:(id)theDelegate
{
	data = [[NSMutableData dataWithCapacity:256] retain];
	statusCode = 0;
	connection = theConnection;
	delegate = theDelegate;
	return self;
}

- (void)dealloc
{
	[data release];
	connection = nil;
	delegate = nil;
    [super dealloc];
}


@end

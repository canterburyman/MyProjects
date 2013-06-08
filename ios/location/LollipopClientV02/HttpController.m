//
//  HttpController.m
//  MVCView
//
//  Created by Xinkai wang on 9/20/10.
//  Copyright 2010 MSFT. All rights reserved.
//

#import "HttpController.h"

@implementation HttpController

static HttpController* _singletonInstance = nil;

+(HttpController*)getInstance
{
	if (_singletonInstance != nil)
	{
		return _singletonInstance;
	}
	else // _singletonInstance == nil
	{
		@synchronized([HttpController class])
		{
			if (!_singletonInstance)
				_singletonInstance = [[super allocWithZone:nil] init];
			
			return _singletonInstance;
		}
	}
	
	return nil;
}

- (HttpController*)init
{
	self = [super init];
	if (self != nil)
	{
		connections = [[NSMutableArray arrayWithCapacity:10] retain];
	}
	return self;
}

/*
- (void)postWithURL:(NSURL*)url delegate:(id)_delegate
{
	delegate = _delegate;
	NSString *post = @"ver=1&lid=2222";
	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];  
	
	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];  
	
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];  
	[request setURL:url];  
	[request setHTTPMethod:@"POST"];  
	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];  
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];  
	[request setHTTPBody:postData];  
	
	connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
	if (connection)  
	{  
		self.data = [NSMutableData dataWithCapacity:256];  
	}  
	else  
	{  
		// inform the user that the download could not be made  
	}
}
*/

- (void) _addConnection:(HttpConnection*)http
{
	NSLog(@"_addConnection, before count = %d", connections.count);
	[connections addObject:http];
	// updateNetworkActivityIndicator
	if (connections.count == 1) 
	{
		[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	}
	NSLog(@"_addConnection, after count = %d", connections.count);
}

- (void) _removeConnection:(HttpConnection*)http
{
	NSLog(@"_removeConnection, before count = %d", connections.count);
	[connections removeObject:http];
	// updateNetworkActivityIndicator
	if (connections.count == 0) 
	{
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	}
	NSLog(@"_removeConnection, after count = %d", connections.count);
}


- (HttpConnection *)getWithURL:(NSURL*)url delegate:(id)_delegate
{
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];  
	[request setURL:url];
	[request setHTTPMethod:@"GET"];
	
	NSURLConnection * connection = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
	
	if (connection)
	{  
		HttpConnection * http = [[[HttpConnection alloc] initWithURLConnection:connection delegate:_delegate] autorelease];
		if (http != nil)
		{
			[self _addConnection:http];
			return http;
		}
	}
	else  
	{  
		NSLog(@"ERROR: getWithURL(): connection could not be made");
		// inform the user that the download could not be made  
	}
	return nil;
}

- (HttpConnection*) findByConnection:(NSURLConnection *)theConnection
{
	HttpConnection* http = nil;
	for(http in connections)
	{
		if (http.connection == theConnection) 
		{
			return http;
		}
	}
	return nil;
}

// cancel all pending connections (if any)
- (void)cancelAllPendingConnection
{
	if (connections.count != 0)
	{
		HttpConnection * http = nil;
		for(http in connections)
		{
			[http.connection cancel];
		}
		[connections removeAllObjects];
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	}
}

// A delegate method called by the NSURLConnection when the connection has been 
// done successfully.  We shut down the connection with a nil status, which 
// causes the image to be displayed.
- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection
{
	HttpConnection * http = [self findByConnection:theConnection];
	
    NSLog(@"respons finished, lenth = %d", http.data.length);
	
	NSString* aStr = nil;
	aStr = [[[NSString alloc] initWithData:http.data encoding:NSUTF8StringEncoding] autorelease];
	id<HttpDelegate> delegate = http.delegate;
	[delegate HttpResponseArrived:aStr source:http];
	
	[self _removeConnection:http];
}

// A delegate method called by the NSURLConnection when fail
- (void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error
{
	HttpConnection * http = [self findByConnection:theConnection];
	
    NSLog(@"respons finished with error, lenth = %d, error = %@", http.data.length, error);
	
	NSString* aStr = nil;
	aStr = [[[NSString alloc] initWithData:http.data encoding:NSUTF8StringEncoding] autorelease];
	id<HttpDelegate> delegate = http.delegate;
	[delegate HttpResponseArrived:aStr source:http];
	
	[self _removeConnection:http];
}

// A delegate method called by the NSURLConnection when the request/response 
// exchange is complete.  We look at the response to check that the HTTP 
// status code is 2xx and that the Content-Type is acceptable.  If these checks 
// fail, we give up on the transfer.
- (void)connection:(NSURLConnection *)theConnection didReceiveResponse:(NSURLResponse *)response
{
	HttpConnection * http = [self findByConnection:theConnection];
    NSHTTPURLResponse * httpResponse;
	
    httpResponse = (NSHTTPURLResponse *) response;
    assert( [httpResponse isKindOfClass:[NSHTTPURLResponse class]] );
    
	http.statusCode = httpResponse.statusCode;
    if ((httpResponse.statusCode / 100) != 2) {
        //[self _stopReceiveWithStatus:[NSString stringWithFormat:@"HTTP error %zd", (ssize_t) httpResponse.statusCode]];
    } else {
        NSLog(@"response OK, data lenth = %d", http.data.length);
    }
	NSLog(@"response %d, data lenth = %d", http.statusCode, http.data.length);
}

// A delegate method called by the NSURLConnection as data arrives.  We just 
// write the data to the file.
- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)_data
{
	HttpConnection * http = [self findByConnection:theConnection];
    NSInteger       dataLength;
	
    dataLength = [http.data length];
	NSLog(@"received data length = %d", dataLength);
	[http.data appendData:_data];
}

- (void)dealloc
{
	[connections release]; connections = nil;
	
    [super dealloc];
}


@end

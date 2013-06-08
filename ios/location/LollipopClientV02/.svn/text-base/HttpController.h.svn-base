//
//  HttpController.h
//  MVCView
//
//  Created by Xinkai wang on 9/20/10.
//  Copyright 2010 MSFT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpConnection.h"
#import "HttpDelegate.h"

// HttpController is a singleton, please always use getInstance instead of alloc/init
@interface HttpController : NSObject {
	NSMutableArray * connections; // array of HttpConnection*
}

+ (HttpController*)getInstance;

- (HttpController*)init;

//- (void)postWithURL:(NSURL*)url delegate:(id)delegate;

- (HttpConnection*)getWithURL:(NSURL*)url delegate:(id<HttpDelegate>)delegate;

- (HttpConnection*)findByConnection:(NSURLConnection *)theConnection;

// cancel all pending connections (if any)
- (void)cancelAllPendingConnection;

// A delegate method called by the NSURLConnection when the connection has been done successfully.
- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection;
// A delegate method called by the NSURLConnection when the response header is complete (my understanding)
- (void)connection:(NSURLConnection *)theConnection didReceiveResponse:(NSURLResponse *)response;
// A delegate method called by the NSURLConnection as data arrives.  (can be called multipl times)
- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)_data;

@end

//
//  TransportLayer.m
//  LollpopClientV1
//
//  Created by Xinkai wang on 9/6/10.
//  Copyright 2010 MSFT. All rights reserved.
//

#import "TransportLayer.h"
#import "HttpController.h"
#import "JSON.h"

@implementation TransportLayer

@synthesize hostNamePortPath;


- (void) setDelegate:(id<TransportLayerDelegate>)_delegate
{
	delegate = _delegate;
}

// return YES when success
+ (BOOL) parseLocation:(NSString *)content 
				   lid:(NSString**)pLid
			  location:(LocationReport*)location 
{
	// local vars
	NSString * lid = nil;
	NSString * cor = nil;
	NSString * acc = nil;
	NSString * time = nil;
	
    NSDictionary *contentDict = [content JSONValue];
    
	// parse
	NSArray * contentArray = [content componentsSeparatedByString:@";"];
	for(NSString * part in contentArray)
	{
		if (![part isEqualToString:@""]) {
			NSArray * keyValue = [part componentsSeparatedByString:@"="];
			if (keyValue.count == 2)
			{
				NSString * key = [keyValue objectAtIndex:0];
				if ([key isEqualToString:@"lid"]) 
				{
					lid = [keyValue objectAtIndex:1];
				}
				else if ([key isEqualToString:@"cor"])
				{
					cor = [keyValue objectAtIndex:1];
				}
				else if ([key isEqualToString:@"locacc"])
				{
					acc = [keyValue objectAtIndex:1];
				}
				else if ([key isEqualToString:@"time"])
				{
					time = [keyValue objectAtIndex:1];
				}
			}
		}
	}
	
	if (lid == nil || cor == nil)
		return NO;
	if (location == nil)
		return NO;
	
	// deposit into data structure
	NSArray * arrLatLong = [cor componentsSeparatedByString:@","];
	location->cor.latitude = [[arrLatLong objectAtIndex:0] doubleValue];
	location->cor.longitude = [[arrLatLong objectAtIndex:1] doubleValue];

	if (pLid != nil)
		*pLid = lid;
	
	if (acc != nil) {
		location->acc = [acc doubleValue];
	}
	if (time != nil) {
		location->timestamp = [time longLongValue];
	}
	
	NSLog(@"new location parsed: %.8f, %.8f", location->cor.latitude, location->cor.longitude);
	return YES;
}

- (void) retquestLocation:(NSString*)lid // normally call this every 5 seconds to get constant update.
{
    LocationReport location;
	NSString * strUrl = [NSString stringWithFormat:@"http://a004.stracking.com/api/v0/json/QueryTracker?tracker_id=%@&auth_token=22345678", lid];
    
    
    NSDictionary *result = [[NSString stringWithContentsOfURL:[NSURL URLWithString:strUrl] encoding:NSUTF8StringEncoding error:nil] JSONValue];
    
    if ([[result objectForKey:@"stat"] isEqual:@"ok"]) {
        
        NSDictionary *updates = [result objectForKey:@"Tracker"];
        NSDictionary *singleUpdate = [[updates objectForKey:@"Updates"] lastObject];
        location.acc = [[singleUpdate objectForKey:@"AccH"] floatValue];
        location.cor = CLLocationCoordinate2DMake([[singleUpdate objectForKey:@"Lat"] floatValue], [[singleUpdate objectForKey:@"Long"] floatValue]);
        location.timestamp = [[singleUpdate objectForKey:@"TS"] longLongValue];
        
        [delegate didUpdateToLocation:&location lid:lid];
    }
    else{
        NSLog(@"Query failed with error: %@", [result objectForKey:@"stat"]);
    }
    
    
}

- (void) HttpResponseArrived:(NSString*)strContent source:(HttpConnection*)src
{
	NSLog(strContent, nil);
	//contentLabel.text = content;
//	if (src.statusCode == 200)
//	{
//		LocationReport location;
//		NSString * lid;
//		BOOL ret = [TransportLayer parseLocation:strContent lid:&lid location:&location];
//		if (ret)
//		{
//			[delegate didUpdateToLocation:&location lid:lid];
//		}
	//}
}


@end

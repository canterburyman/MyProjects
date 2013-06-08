//
//  TestJsonTests.m
//  TestJsonTests
//
//  Created by Xinjun Email on 25/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TestJsonTests.h"
#import "JSON.h"

@implementation TestJsonTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

//- (void)testExample
//{
//    NSString *urlString = @"http://a004.stracking.com:8003/api/v0/json/UserQueryTrackers?user_id=2&timestamp=0&auth_token=22345678&updatetypes=1,10";
//	NSDictionary *contentInJson = [[NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:nil] JSONValue];
//    
//    NSLog(@"Json: %@", contentInJson);
//}

- (void)testTimeParser
{
    NSString *urlString = @"2012-06-20T09:13:51"; //@"2012-06-12T15:20:12"; //
    NSString *time = @"02:23:51";
    NSString *trackerName = @"my tracker";
    NSLog(@"%s", [trackerName UTF8String]);
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSDate *validDate = [df dateFromString:urlString] ;
    
    NSTimeInterval interval = [validDate timeIntervalSinceNow];
    NSString *tmp = [@"my tracker" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //NSURL *url = [NSURL URLWithString:@"http://a010.stracking.com/RestAccSatService/mytracker"];
    NSLog(@"%@", tmp);
    [df release];

}


@end

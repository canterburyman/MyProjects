//
//  TestUnitTestsTests.m
//  TestUnitTestsTests
//
//  Created by Jane Ching on 15/04/12.
//  Copyright (c) 2012 UOW. All rights reserved.
//

#import "TestUnitTestsTests.h"
#import "StudentViewController.h"
#import "Student.h"

@implementation TestUnitTestsTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    NSBundle * bundle = [NSBundle bundleForClass:[self class]];
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles: [NSArray arrayWithObject:bundle]] retain];
    NSLog(@"model: %@", managedObjectModel);
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    persistentStore = [persistentStoreCoordinator addPersistentStoreWithType:NSInMemoryStoreType
                                                               configuration:nil
                                                                         URL:nil
                                                                     options:nil 
                                                                       error:NULL];
    managedObjectContext = [[NSManagedObjectContext alloc] init];
    [managedObjectContext setPersistentStoreCoordinator:persistentStoreCoordinator];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
    [managedObjectContext release];
    managedObjectContext = nil;
    NSError *error = nil;
    STAssertTrue([persistentStoreCoordinator removePersistentStore:persistentStore error:&error], 
                 @"couldn't remove persistent store: %@", error);
    persistentStore = nil;
    [persistentStoreCoordinator release];
    persistentStoreCoordinator = nil;
    [managedObjectModel release];
    managedObjectModel = nil;
}

- (void)testExample
{
    STAssertTrue(YES, @"Unit tests are not implemented yet in TestUnitTestsTests");
}


- (void) testAddStudent
{
    Student *newStudent = [Student studentWithName:@"student123" InObjectContext:managedObjectContext];
    STAssertNotNil(newStudent, @"create student failed?");
}

- (void) testDeleteStudent
{
    Student *newStudent = [Student studentWithName:@"student234" InObjectContext:managedObjectContext];
    STAssertNotNil(newStudent, @"create student failed?");
    
    NSUInteger totalCount = [Student countForStudent:managedObjectContext];
    if(totalCount > 0)
    {
        [Student deleteRandomStudent:managedObjectContext];
        NSUInteger newCount = [Student countForStudent:managedObjectContext];
        STAssertTrue(totalCount-1 == newCount, @"the count not descreased by 1 after deletion");
    }
}

- (void)targetMethod:(NSTimer*)theTimer {
    
    NSDate *startDate = [[theTimer userInfo] objectForKey:@"StartDate"];
    NSLog(@"Timer started on %@", startDate);
}


- (NSDictionary *)userInfo {
    return [NSDictionary dictionaryWithObject:[NSDate date] forKey:@"StartDate"];
}

-(void) testTimer
{
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(targetMethod:)
                                   userInfo:[self userInfo]
                                    repeats:NO];
    
    NSDate *runUntil = [NSDate dateWithTimeIntervalSinceNow: 3.0 ];  
    [[NSRunLoop currentRunLoop] runUntilDate:runUntil];  
}




@end

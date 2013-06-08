//
//  TestUnitTestsTests.h
//  TestUnitTestsTests
//
//  Created by Jane Ching on 15/04/12.
//  Copyright (c) 2012 UOW. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@interface TestUnitTestsTests : SenTestCase
{
    NSManagedObjectContext *managedObjectContext;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSPersistentStore *persistentStore;
}

@end

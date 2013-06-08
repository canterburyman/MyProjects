//
//  TestNSFetchedAppDelegate.h
//  TestNSFetched
//
//  Created by Jane Ching on 12/04/12.
//  Copyright 2012 UOW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestNSFetchedAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

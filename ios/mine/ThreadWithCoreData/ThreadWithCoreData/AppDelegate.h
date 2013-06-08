//
//  AppDelegate.h
//  ThreadWithCoreData
//
//  Created by Xinjun Email on 24/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (retain, nonatomic) NSFetchedResultsController *fetchedResultsController;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

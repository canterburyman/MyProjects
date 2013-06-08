//
//  ThreadManager.h
//  ThreadWithCoreData
//
//  Created by Xinjun Email on 24/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThreadManager : NSObject <NSFetchedResultsControllerDelegate>

@property (retain, nonatomic) NSThread *imageSaverThread;

@property (retain, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (retain, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (retain, nonatomic) NSFetchedResultsController *fetchedResultsController;

- (void) start;

@end

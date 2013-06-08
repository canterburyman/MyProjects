//
//  BlockManager.h
//  ThreadWithCoreData
//
//  Created by Xinjun Email on 24/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlockManager : NSObject <NSFetchedResultsControllerDelegate>

@property (retain, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (retain, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (retain, nonatomic) NSFetchedResultsController *fetchedResultsController;

- (void) start;

@end

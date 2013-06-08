//
//  BlockManager.m
//  ThreadWithCoreData
//
//  Created by Xinjun Email on 24/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BlockManager.h"

@implementation BlockManager

@synthesize persistentStoreCoordinator, managedObjectContext;
@synthesize fetchedResultsController;

- (void) start {
    
    dispatch_queue_t coreDataQueue = dispatch_queue_create("spy on entity", NULL);
    dispatch_async(coreDataQueue, ^{
        self.managedObjectContext = [[[NSManagedObjectContext alloc] initWithConcurrencyType:NSConfinementConcurrencyType] autorelease];
        [self.managedObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
        [self registerFectchRequestResults];
    });
}

-(void) registerFectchRequestResults
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //NSManagedObjectContext *context = place.managedObjectContext;
    request.entity = [NSEntityDescription entityForName:@"Entity" inManagedObjectContext:self.managedObjectContext];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO]];
    request.predicate = nil;
    request.fetchBatchSize = 20;
    
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    [request release];
    
    self.fetchedResultsController = frc;
    self.fetchedResultsController.delegate = self;
    [frc release];
    
    [self.fetchedResultsController performFetch:NULL];
}


- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
	   atIndexPath:(NSIndexPath *)indexPath
	 forChangeType:(NSFetchedResultsChangeType)type
	  newIndexPath:(NSIndexPath *)newIndexPath
{	
    NSLog(@"didChangeObject:%@ atIndexPath:%@ forChangeType:%d newIndexPath:%@", anObject, indexPath, type, newIndexPath);
    
}



@end

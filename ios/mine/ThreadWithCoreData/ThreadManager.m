//
//  ThreadManager.m
//  ThreadWithCoreData
//
//  Created by Xinjun Email on 24/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ThreadManager.h"

@implementation ThreadManager
@synthesize imageSaverThread;
@synthesize persistentStoreCoordinator, managedObjectContext;

@synthesize fetchedResultsController;

- (void) start {
    self.imageSaverThread = [[[NSThread alloc] initWithTarget:self selector:@selector(imageSaverThreadMain) object:nil] autorelease];
    [self.imageSaverThread start];
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



- (void) imageSaverKeepAlive {
    [self performSelector:@selector(imageSaverKeepAlive) withObject:nil afterDelay:60];    
}

- (void)imageSaverThreadMain
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    // Add selector to prevent CFRunLoopRunInMode from returning immediately
    [self performSelector:@selector(imageSaverKeepAlive) withObject:nil afterDelay:60];
    BOOL done = NO;
    
    self.managedObjectContext = [[[NSManagedObjectContext alloc] initWithConcurrencyType:NSConfinementConcurrencyType] autorelease];
    [self.managedObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    
    [self registerFectchRequestResults];
    do
    {
        NSAutoreleasePool *tempPool = [[NSAutoreleasePool alloc] init];
        // Start the run loop but return after each source is handled.
        SInt32    result = CFRunLoopRunInMode(kCFRunLoopDefaultMode, 10, YES);
        
        // If a source explicitly stopped the run loop, or if there are no
        // sources or timers, go ahead and exit.
        if ((result == kCFRunLoopRunStopped) || (result == kCFRunLoopRunFinished))
            done = YES;
        
        [tempPool release];
    }
    while (!done);
    
    [pool release];
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

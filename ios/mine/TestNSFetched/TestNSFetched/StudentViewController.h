//
//  StudentViewController.h
//  TestNSFetched
//
//  Created by Jane Ching on 12/04/12.
//  Copyright 2012 UOW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@interface StudentViewController : CoreDataTableViewController{ //UIViewController <NSFetchedResultsControllerDelegate>{ //
    
    IBOutlet UITextView *textView;
    NSFetchedResultsController *frc;
}

@property (retain) NSManagedObjectContext *context;
@property (retain, nonatomic) NSFetchedResultsController *frc;

- (IBAction)pressAdd:(id)sender;
- (IBAction)pressChangeName:(id)sender;
- (IBAction)pressTestJson:(id)sender;

-initWithObjectContext:(NSManagedObjectContext*) newContext;
@end

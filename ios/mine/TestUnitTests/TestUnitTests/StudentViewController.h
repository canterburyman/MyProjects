//
//  StudentViewController.h
//  TestUnitTests
//
//  Created by Jane Ching on 15/04/12.
//  Copyright (c) 2012 UOW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentViewController : UIViewController <NSFetchedResultsControllerDelegate>{ 
    
    IBOutlet UITextView *textView;
    NSFetchedResultsController *frc;
}

@property (retain) NSManagedObjectContext *context;
@property (retain, nonatomic) NSFetchedResultsController *frc;

- (IBAction)pressAdd:(id)sender;
- (IBAction)pressChangeName:(id)sender;
- (IBAction)pressDelete:(id)sender;
- (IBAction)pressTestJson:(id)sender;

-initWithObjectContext:(NSManagedObjectContext*) newContext;
@end

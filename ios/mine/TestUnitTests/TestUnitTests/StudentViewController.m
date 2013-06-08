//
//  StudentViewController.m
//  TestUnitTests
//
//  Created by Jane Ching on 15/04/12.
//  Copyright (c) 2012 UOW. All rights reserved.
//

#import "StudentViewController.h"
#import "Student.h"
//#import "JSON.h"

@implementation StudentViewController
@synthesize context, frc;


-initWithObjectContext:(NSManagedObjectContext*) newContext
{
    self = [super initWithNibName:nil bundle:nil];
    if(self)
    {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        //NSManagedObjectContext *context = place.managedObjectContext;
        request.entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:newContext];
        request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO selector:@selector(compare:)]];
        
        request.predicate = [NSPredicate predicateWithFormat:@"uniqueId < 500"];
        request.fetchBatchSize = 20;
        
        NSFetchedResultsController *newfrc = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:newContext sectionNameKeyPath:nil cacheName:nil];
        [request release];
		
		self.frc = newfrc;
		[newfrc release];
		
		//self.titleKey = @"name";
        self.context = newContext;
    }
    return self;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [textView release];
    [context release];
    [frc release];
    [super dealloc];
}

- (void)setFrc:(NSFetchedResultsController *)newFrc
{
    frc.delegate = nil;
    [frc release];
    frc = [newFrc retain];
    newFrc.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

//- (void)contextChanged:(NSNotification *)note
//{
//    NSLog(@"notification:%@", note);
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contextChanged:) name:NSManagedObjectContextObjectsDidChangeNotification object:self.context];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.frc performFetch:NULL];
}

- (void)viewDidUnload
{
    [textView release];
    textView = nil;
    self.frc = nil;
    self.context = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSManagedObjectContextObjectsDidChangeNotification object:self.context];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) contextSave
{
    NSError *error = nil;
    [self.context save:&error];
    if(error) NSLog(@"%@", error);
}

- (IBAction)pressAdd:(id)sender {
    
    NSNumber *randomNum = [NSNumber numberWithInt:arc4random()%1000];
    NSString *name = [NSString stringWithFormat:@"student%@", randomNum];
    
    Student *newStudent = [Student studentWithName:name InObjectContext:self.context];
    
    //display the student's name in the textview
    textView.text = [textView.text stringByAppendingFormat:@"Add new Student:%@\n", newStudent.name];
    [self contextSave];
}

//- (void)managedObjectSelected:(NSManagedObject *)managedObject
//{
//    Student *student = (Student *) managedObject;
//    
//    student.name = [NSString stringWithFormat:@"%@_1", student.name];
//    NSError *error = nil;
//    [self.context save:&error];
//    if(error) NSLog(@"%@", error);
//}

- (IBAction)pressChangeName:(id)sender
{
    
    Student *random = [Student getRandomStudent:self.context];
    textView.text = [textView.text stringByAppendingFormat:@"Student's name change from:%@ to %@_1\n", random.name, random.name];
    [random willChangeValueForKey:@"name"];
    random.name = [NSString stringWithFormat:@"%@_1", random.name];
    [random didChangeValueForKey:@"name"];
    [self contextSave];
}


- (IBAction)pressDelete:(id)sender
{
    Student *random = [Student getRandomStudent:self.context];
    textView.text = [textView.text stringByAppendingFormat:@"Delete Student:%@\n", random.name];
    [self.context deleteObject:random];
    [self contextSave];
}

//-(void) testJSON
//{
//    NSArray *array1 = [NSArray arrayWithObjects:@"hello", @"world", @"ni", @"hao", @"ma", nil];
//    
//    NSString *serializeStr = [array1 JSONRepresentation];
//    NSLog(@"serializeStr:%@", serializeStr);
//    
//    NSArray *jsonArray = [serializeStr JSONValue];
//    NSLog(@"jsonArray:%@", jsonArray);
//}

- (IBAction)pressTestJson:(id)sender
{
    [Student countForStudent:self.context];;
    NSArray *students = [self.context executeFetchRequest:self.frc.fetchRequest error:NULL];
    NSLog(@"students:%@", students);
    
    textView.text = [textView.text stringByAppendingString:@"Student List:\n"];
    for (Student *s in students) {
        textView.text = [textView.text stringByAppendingFormat:@"%@ ", s.name];
    }
    textView.text = [textView.text stringByAppendingString:@"\n"];
    [self contextSave];
}


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    NSLog(@"controllerWillChangeContent");
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    NSLog(@"controllerDidChangeContent");
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
		   atIndex:(NSUInteger)sectionIndex
	 forChangeType:(NSFetchedResultsChangeType)type
{	
    NSLog(@"didChangeSection:%@ atIndex:%@ forChangeType:%d",
          sectionInfo, sectionIndex, type);
}


- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
	   atIndexPath:(NSIndexPath *)indexPath
	 forChangeType:(NSFetchedResultsChangeType)type
	  newIndexPath:(NSIndexPath *)newIndexPath
{	
    NSLog(@"didChangeObject:%@ atIndexPath:%@ forChangeType:%d newIndexPath:%@",
          anObject, indexPath, type, newIndexPath);
}

@end

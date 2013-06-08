//
//  StudentViewController.m
//  TestNSFetched
//
//  Created by Jane Ching on 12/04/12.
//  Copyright 2012 UOW. All rights reserved.
//

#import "StudentViewController.h"
#import "Student.h"
#import "JSON.h"

@implementation StudentViewController
@synthesize context, frc;


-initWithObjectContext:(NSManagedObjectContext*) newContext
{
    if ( self == [super initWithStyle:UITableViewStylePlain])
    {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        //NSManagedObjectContext *context = place.managedObjectContext;
        request.entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:newContext];
        request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO selector:@selector(compare:)]];
       
        request.predicate = nil;
        request.fetchBatchSize = 20;
        
        NSFetchedResultsController *newfrc = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:newContext sectionNameKeyPath:nil cacheName:nil];
        [request release];
		
		self.fetchedResultsController = newfrc;
		[newfrc release];
		
		self.titleKey = @"name";
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

//-(void)loadView
//{
//    [super loadView];
//    StudentViewController *svc = [[StudentViewController alloc] init];
//    [self.view addSubview: svc.view];
//
//}

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
    frc.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)contextChanged:(NSNotification *)note
{
    NSLog(@"notification:%@", note);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contextChanged:) name:NSManagedObjectContextObjectsDidChangeNotification object:self.context];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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

- (IBAction)pressAdd:(id)sender {
    
    NSNumber *randomNum = [NSNumber numberWithInt:arc4random()%1000];
    NSString *name = [NSString stringWithFormat:@"studuent%@", randomNum];
    
    Student *newStudent = [Student studentWithName:name InObjectContext:self.context];
    
    //display the student's name in the textview
    textView.text = [textView.text stringByAppendingFormat:@"Add new Student:%@\n", newStudent.name];
}

- (void)managedObjectSelected:(NSManagedObject *)managedObject
{
    Student *student = (Student *) managedObject;
    
    student.name = [NSString stringWithFormat:@"%@_1", student.name];
    NSError *error = nil;
    [self.context save:&error];
    if(error) NSLog(@"%@", error);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self pressChangeName:nil];
}

- (IBAction)pressChangeName:(id)sender
{
    
//    if(!self.frc)
//    {
//        NSFetchRequest *request = [[NSFetchRequest alloc] init];
//        request.entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:self.context];
//        request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)]];
//        request.predicate = nil;
//        request.fetchBatchSize = 20;
//        
//        NSFetchedResultsController *controller = [[NSFetchedResultsController alloc]
//                                           initWithFetchRequest:request
//                                           managedObjectContext:self.context
//                                           sectionNameKeyPath:nil
//                                           cacheName:nil];
//        
//        self.frc = controller;
//        //self.fetchedResultsController = controller;
//        [controller release];
//        [request release];
//    }
    
    Student *random = [Student getRandomStudent:self.context];
    textView.text = [textView.text stringByAppendingFormat:@"Student's name change from:%@ to %@_1\n", random.name, random.name];
    [random willChangeValueForKey:@"name"];
    random.name = [NSString stringWithFormat:@"%@_1", random.name];
    [random didChangeValueForKey:@"name"];
    NSError *error = nil;
    [self.context save:&error];
    if(error) NSLog(@"%@", error);
    
    NSArray *newArray = [self.context executeFetchRequest:self.fetchedResultsController.fetchRequest error:NULL];
    NSLog(@"New student table:%@", newArray);
}

-(void) testJSON
{
    NSArray *array1 = [NSArray arrayWithObjects:@"hello", @"world", @"ni", @"hao", @"ma", nil];
    
    NSString *serializeStr = [array1 JSONRepresentation];
    NSLog(@"serializeStr:%@", serializeStr);
    
    NSArray *jsonArray = [serializeStr JSONValue];
    NSLog(@"jsonArray:%@", jsonArray);
}

- (IBAction)pressTestJson:(id)sender
{
    [self testJSON];
}


@end

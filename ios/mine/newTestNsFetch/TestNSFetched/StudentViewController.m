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
#import "MyClass.h"
#import "Entity1.h"
#import "Entity2.h"
#import "Entity3.h"
#import "Entity4.h"

#import "Entity5.h"
#import "Entity6.h"

@implementation StudentViewController
@synthesize context, frc;


-initWithObjectContext:(NSManagedObjectContext*) newContext
{
    self = [super initWithNibName:nil bundle:nil];
    if(self)
    {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        //NSManagedObjectContext *context = place.managedObjectContext;
        request.entity = [NSEntityDescription entityForName:@"MyClass" inManagedObjectContext:newContext];
        request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"classId" ascending:NO selector:@selector(compare:)]];
       
        request.predicate = [NSPredicate predicateWithFormat:@"students.name = %@", @"student10"];
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
    
    Entity1 *entity1 = [Entity1 entityWithName:@"entity1" InObjectContext:self.context];
    Entity2 *entity2 = [Entity2 entityWithName:@"entity2" InObjectContext:self.context];
    entity1.relationToEntity2 = entity2;
    
    [self.context deleteObject:entity1];
    NSError *err = nil;
    [self.context save:&err];
    entity2.uniqueId = @"entity2";
    NSLog(@"%@", entity2);
    [self.context save:&err];
    if(err) NSLog(@"save1:%@", err);
    
    //test cascade one-one relationship
    Entity3 *entity3 = [Entity3 entityWithName:@"entity3" InObjectContext:self.context];
    Entity4 *entity4 = [Entity4 entityWithName:@"entity4" InObjectContext:self.context];
    entity3.relationshipEntity4 = entity4;
    
    entity3.uniqueId = @"entity3";
    [self.context save:&err];
    if(err) NSLog(@"save2:%@", err);
    
    [self.context deleteObject:entity4];
    err = nil;
    [self.context save:&err];
    
    entity3.uniqueId = @"entity3";
    [self.context save:&err];
    if(err) NSLog(@"save3:%@", err);
    
    //test cascade one-multiple relationship
    Entity5 *entity5 = [Entity5 entityWithName:@"entity5" InObjectContext:self.context];
    Entity6 *entity6_1 = [Entity6 entityWithName:@"entity6_1" InObjectContext:self.context];
    Entity6 *entity6_2 = [Entity6 entityWithName:@"entity6_2" InObjectContext:self.context];
    
    [entity5 addMultiRelationShipEntity6:[NSSet setWithObjects:entity6_1, entity6_2, nil]];
    [self.context deleteObject:entity5];
    err = nil;
    [self.context save:&err];
    
    NSLog(@"%@", entity6_1); NSLog(@"%@", entity6_2);
    
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
    
    //NSNumber *randomNum = [NSNumber numberWithInt:arc4random()%1000];
    NSString *name = [NSString stringWithFormat:@"student%d", 10];
    
    Student *newStudent = [Student studentWithName:name InObjectContext:self.context];
    
    MyClass *class1 = [MyClass classWithName:@"class1" InObjectContext:self.context];
    MyClass *class2 = [MyClass classWithName:@"class2" InObjectContext:self.context];
    MyClass *class3 = [MyClass classWithName:@"class3" InObjectContext:self.context];
    
    NSDictionary *classInDict = [[class1 entity] attributesByName];

    
    for (NSString *att in classInDict) {
        NSLog(@"%@", att);
    }
    
    static int count = 0;
    
    int tmp = count%3;
    NSString *tmpStr = [NSString stringWithFormat:@"class%d", arc4random()%1000];
    class1.myClassName = tmpStr;
    
    if (tmp == 0 ) {
        [newStudent addBelongTo:[NSSet setWithObjects:class1, nil]];
    }else if (tmp == 1){
        [newStudent addBelongTo:[NSSet setWithObjects:class1, class2, nil]];
    }else {
        [newStudent addBelongTo:[NSSet setWithObjects:class1, class2, class3, nil]];
    }
    count++;
    //[newStudent addBelongToObject:[MyClass classWithName:@"class1" InObjectContext:self.context]];
    //display the student's name in the textview
    //textView.text = [textView.text stringByAppendingFormat:@"Add new Student:%@\n", newStudent.name];
    
    [self contextSave];
    
    NSLog(@"student 10 got %d classes", newStudent.belongTo.count);
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
    Entity4 *entity = [Entity4 getEntity4:self.context];
    NSLog(@"Entity4:%@", entity);
    
    Entity3 *entity3 = [Entity3 getEntity3:self.context];
    NSLog(@"Entity3:%@", entity3);
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

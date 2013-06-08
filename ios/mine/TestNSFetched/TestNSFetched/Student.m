//
//  Student.m
//  TestNSFetched
//
//  Created by Jane Ching on 12/04/12.
//  Copyright (c) 2012 UOW. All rights reserved.
//

#import "Student.h"


@implementation Student
@dynamic name;

+(Student*) studentWithName:(NSString *)name InObjectContext:(NSManagedObjectContext*) context
{
    Student *student = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    request.entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:context]; 
    request.predicate = [NSPredicate predicateWithFormat:@"name == %@", name];
    
    NSError *error = nil;
    student = [[context executeFetchRequest:request error:&error] lastObject];
    [request release];
    
    if (!error && !student) {
        student = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:context];
        student.name = name;
    }
    return student;
}

+(Student*) getRandomStudent:(NSManagedObjectContext*) context
{
    Student *student = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    request.entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:context]; 
    request.predicate = nil;
    
    NSError *error = nil;
    NSArray *array = [context executeFetchRequest:request error:&error];
    student = [array objectAtIndex:(rand()%array.count)] ;
    [request release];
    
    return student;
}


@end

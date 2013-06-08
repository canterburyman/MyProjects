//
//  Student.m
//  TestUnitTests
//
//  Created by Jane Ching on 15/04/12.
//  Copyright (c) 2012 UOW. All rights reserved.
//

#import "Student.h"


@implementation Student

@dynamic name;
@dynamic uniqueId;


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
        NSRange range = [name rangeOfString:@"student"];
        if (range.length > 0) {
            student.uniqueId = [NSNumber numberWithInt:[[name substringFromIndex:range.length] intValue]];
        }
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

+(void) deleteRandomStudent:(NSManagedObjectContext*) context
{
    Student *random = [Student getRandomStudent:context];
    
    //if get a student
    if (random) {   
        [context deleteObject:random];
    }
    
    NSError *error = nil;
    [context save:&error];
    NSLog(@"deleteRandomStudent:%@", error);
}

+(NSUInteger) countForStudent:(NSManagedObjectContext*) context
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Student" inManagedObjectContext:context]];
    
    [request setIncludesSubentities:NO]; //Omit subentities. Default is YES (i.e. include subentities)

    NSError *err = nil;
    NSUInteger count = [context countForFetchRequest:request error:&err];
    [request release];
    if (!err) {
        return count;
    }else{
        return 0;
    }
}

@end

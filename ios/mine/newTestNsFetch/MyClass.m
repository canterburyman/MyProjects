//
//  MyClass.m
//  TestNSFetched
//
//  Created by Xinjun Email on 16/06/12.
//  Copyright (c) 2012 UOW. All rights reserved.
//

#import "MyClass.h"
#import "Student.h"


@implementation MyClass

@dynamic classId;
@dynamic students;
@dynamic myClassName;


+(MyClass*) classWithName:(NSString *)name InObjectContext:(NSManagedObjectContext*) context
{
    MyClass *myClass = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    request.entity = [NSEntityDescription entityForName:@"MyClass" inManagedObjectContext:context]; 
    request.predicate = [NSPredicate predicateWithFormat:@"classId == %@", name];
    
    NSError *error = nil;
    myClass = [[context executeFetchRequest:request error:&error] lastObject];
    [request release];
    
    if (!error && !myClass) {
        myClass = [NSEntityDescription insertNewObjectForEntityForName:@"MyClass" inManagedObjectContext:context];
        myClass.classId = name;
    }
    return myClass;
}

@end

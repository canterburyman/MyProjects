//
//  Entity4.m
//  TestNSFetched
//
//  Created by Xinjun Email on 23/06/12.
//  Copyright (c) 2012 UOW. All rights reserved.
//

#import "Entity4.h"


@implementation Entity4

@dynamic uniqueId;
@dynamic relationshipEntity4;

+(Entity4*) entityWithName:(NSString *)name InObjectContext:(NSManagedObjectContext*) context
{
    Entity4 *entity = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    request.entity = [NSEntityDescription entityForName:@"Entity4" inManagedObjectContext:context]; 
    request.predicate = [NSPredicate predicateWithFormat:@"uniqueId == %@", name];
    
    NSError *error = nil;
    entity = [[context executeFetchRequest:request error:&error] lastObject];
    [request release];
    
    if (!error && !entity) {
        entity = [NSEntityDescription insertNewObjectForEntityForName:@"Entity4" inManagedObjectContext:context];
        entity.uniqueId = name;
    }
    return entity;
}

+(Entity4*) getEntity4:(NSManagedObjectContext*) context
{
    Entity4 *entity = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    request.entity = [NSEntityDescription entityForName:@"Entity4" inManagedObjectContext:context]; 
    request.predicate = nil;
    
    NSError *error = nil;
    
    entity = [[context executeFetchRequest:request error:&error] lastObject] ;
    [request release];
    
    return entity;
}



@end

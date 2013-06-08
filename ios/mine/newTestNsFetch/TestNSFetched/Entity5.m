//
//  Entity5.m
//  TestNSFetched
//
//  Created by Xinjun Email on 23/06/12.
//  Copyright (c) 2012 UOW. All rights reserved.
//

#import "Entity5.h"


@implementation Entity5

@dynamic uniqueId;
@dynamic multiRelationShipEntity6;

+(Entity5*) entityWithName:(NSString *)name InObjectContext:(NSManagedObjectContext*) context
{
    Entity5 *entity = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    request.entity = [NSEntityDescription entityForName:@"Entity5" inManagedObjectContext:context]; 
    request.predicate = [NSPredicate predicateWithFormat:@"uniqueId == %@", name];
    
    NSError *error = nil;
    entity = [[context executeFetchRequest:request error:&error] lastObject];
    [request release];
    
    if (!error && !entity) {
        entity = [NSEntityDescription insertNewObjectForEntityForName:@"Entity5" inManagedObjectContext:context];
        entity.uniqueId = name;
    }
    return entity;
}

+(Entity5*) getEntity5:(NSManagedObjectContext*) context
{
    Entity5 *entity = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    request.entity = [NSEntityDescription entityForName:@"Entity5" inManagedObjectContext:context]; 
    request.predicate = nil;
    
    NSError *error = nil;
    
    entity = [[context executeFetchRequest:request error:&error] lastObject] ;
    [request release];
    
    return entity;
}
@end

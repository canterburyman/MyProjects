//
//  Entity2.m
//  TestNSFetched
//
//  Created by Xinjun Email on 22/06/12.
//  Copyright (c) 2012 UOW. All rights reserved.
//

#import "Entity2.h"


@implementation Entity2

@dynamic uniqueId;
@dynamic relationToEntity1;

+(Entity2*) entityWithName:(NSString *)name InObjectContext:(NSManagedObjectContext*) context
{
    Entity2 *entity = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    request.entity = [NSEntityDescription entityForName:@"Entity2" inManagedObjectContext:context]; 
    request.predicate = [NSPredicate predicateWithFormat:@"uniqueId == %@", name];
    
    NSError *error = nil;
    entity = [[context executeFetchRequest:request error:&error] lastObject];
    [request release];
    
    if (!error && !entity) {
        entity = [NSEntityDescription insertNewObjectForEntityForName:@"Entity2" inManagedObjectContext:context];
        entity.uniqueId = name;
    }
    return entity;
}

@end

//
//  Entity1.m
//  TestNSFetched
//
//  Created by Xinjun Email on 22/06/12.
//  Copyright (c) 2012 UOW. All rights reserved.
//

#import "Entity1.h"
#import "Entity2.h"


@implementation Entity1

@dynamic uniqueId;
@dynamic relationToEntity2;

+(Entity1*) entityWithName:(NSString *)name InObjectContext:(NSManagedObjectContext*) context
{
    Entity1 *entity = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    request.entity = [NSEntityDescription entityForName:@"Entity1" inManagedObjectContext:context]; 
    request.predicate = [NSPredicate predicateWithFormat:@"uniqueId == %@", name];
    
    NSError *error = nil;
    entity = [[context executeFetchRequest:request error:&error] lastObject];
    [request release];
    
    if (!error && !entity) {
        entity = [NSEntityDescription insertNewObjectForEntityForName:@"Entity1" inManagedObjectContext:context];
        entity.uniqueId = name;
    }
    return entity;
}

@end

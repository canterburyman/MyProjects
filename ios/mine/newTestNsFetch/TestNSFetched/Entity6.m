//
//  Entity6.m
//  TestNSFetched
//
//  Created by Xinjun Email on 23/06/12.
//  Copyright (c) 2012 UOW. All rights reserved.
//

#import "Entity6.h"
#import "Entity5.h"


@implementation Entity6

@dynamic uniqueId;
@dynamic relationToEntity5;


+(Entity6*) entityWithName:(NSString *)name InObjectContext:(NSManagedObjectContext*) context
{
    Entity6 *entity = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    request.entity = [NSEntityDescription entityForName:@"Entity6" inManagedObjectContext:context]; 
    request.predicate = [NSPredicate predicateWithFormat:@"uniqueId == %@", name];
    
    NSError *error = nil;
    entity = [[context executeFetchRequest:request error:&error] lastObject];
    [request release];
    
    if (!error && !entity) {
        entity = [NSEntityDescription insertNewObjectForEntityForName:@"Entity6" inManagedObjectContext:context];
        entity.uniqueId = name;
    }
    return entity;
}

@end

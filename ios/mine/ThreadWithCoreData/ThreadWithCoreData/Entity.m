//
//  Entity.m
//  ThreadWithCoreData
//
//  Created by Xinjun Email on 24/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Entity.h"


@implementation Entity

@dynamic name;
@dynamic entityId;

+(Entity*) getEntityById:(NSString *)name ObjectContext:(NSManagedObjectContext*) context
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"Entity" inManagedObjectContext:context];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    
    NSError *err = nil;
    Entity *entity = [[context executeFetchRequest:request error:&err] lastObject];
    if(err) NSLog(@"productById executeFetchRequest error:%@", err);
    [request release];
    if(!entity)
    {
        entity = [NSEntityDescription insertNewObjectForEntityForName:@"Entity" inManagedObjectContext:context];
        entity.name = name;
    }
    
    
    return entity;
}

@end

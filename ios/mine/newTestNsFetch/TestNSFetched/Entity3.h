//
//  Entity3.h
//  TestNSFetched
//
//  Created by Xinjun Email on 23/06/12.
//  Copyright (c) 2012 UOW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Entity4;

@interface Entity3 : NSManagedObject

@property (nonatomic, retain) NSString * uniqueId;
@property (nonatomic, retain) Entity4 *relationshipEntity4;

+(Entity3*) entityWithName:(NSString *)name InObjectContext:(NSManagedObjectContext*) context;
+(Entity3*) getEntity3:(NSManagedObjectContext*) context;
@end

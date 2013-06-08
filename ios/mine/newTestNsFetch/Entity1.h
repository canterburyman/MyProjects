//
//  Entity1.h
//  TestNSFetched
//
//  Created by Xinjun Email on 22/06/12.
//  Copyright (c) 2012 UOW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Entity2;

@interface Entity1 : NSManagedObject

@property (nonatomic, retain) NSString * uniqueId;
@property (nonatomic, retain) Entity2 *relationToEntity2;

+(Entity1*) entityWithName:(NSString *)name InObjectContext:(NSManagedObjectContext*) context;

@end

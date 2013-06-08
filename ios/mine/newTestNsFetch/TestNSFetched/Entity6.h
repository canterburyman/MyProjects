//
//  Entity6.h
//  TestNSFetched
//
//  Created by Xinjun Email on 23/06/12.
//  Copyright (c) 2012 UOW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Entity5;

@interface Entity6 : NSManagedObject

@property (nonatomic, retain) NSString * uniqueId;
@property (nonatomic, retain) Entity5 *relationToEntity5;

+(Entity6*) entityWithName:(NSString *)name InObjectContext:(NSManagedObjectContext*) context;

@end

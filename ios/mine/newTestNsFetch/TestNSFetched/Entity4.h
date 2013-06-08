//
//  Entity4.h
//  TestNSFetched
//
//  Created by Xinjun Email on 23/06/12.
//  Copyright (c) 2012 UOW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entity4 : NSManagedObject

@property (nonatomic, retain) NSString * uniqueId;
@property (nonatomic, retain) NSManagedObject *relationshipEntity4;

+(Entity4*) entityWithName:(NSString *)name InObjectContext:(NSManagedObjectContext*) context;
+(Entity4*) getEntity4:(NSManagedObjectContext*) context;
@end

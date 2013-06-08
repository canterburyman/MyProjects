//
//  Entity2.h
//  TestNSFetched
//
//  Created by Xinjun Email on 22/06/12.
//  Copyright (c) 2012 UOW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entity2 : NSManagedObject

@property (nonatomic, retain) NSString * uniqueId;
@property (nonatomic, retain) NSManagedObject *relationToEntity1;

+(Entity2*) entityWithName:(NSString *)name InObjectContext:(NSManagedObjectContext*) context;

@end

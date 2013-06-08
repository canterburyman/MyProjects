//
//  Entity5.h
//  TestNSFetched
//
//  Created by Xinjun Email on 23/06/12.
//  Copyright (c) 2012 UOW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entity5 : NSManagedObject

@property (nonatomic, retain) NSString * uniqueId;
@property (nonatomic, retain) NSSet *multiRelationShipEntity6;
@end

@interface Entity5 (CoreDataGeneratedAccessors)

- (void)addMultiRelationShipEntity6Object:(NSManagedObject *)value;
- (void)removeMultiRelationShipEntity6Object:(NSManagedObject *)value;
- (void)addMultiRelationShipEntity6:(NSSet *)values;
- (void)removeMultiRelationShipEntity6:(NSSet *)values;


+(Entity5*) entityWithName:(NSString *)name InObjectContext:(NSManagedObjectContext*) context;
+(Entity5*) getEntity5:(NSManagedObjectContext*) context;

@end

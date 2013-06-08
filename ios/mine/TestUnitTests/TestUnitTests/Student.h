//
//  Student.h
//  TestUnitTests
//
//  Created by Jane Ching on 15/04/12.
//  Copyright (c) 2012 UOW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Student : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * uniqueId;


+(Student*) studentWithName:(NSString *)name InObjectContext:(NSManagedObjectContext*) context;
+(Student*) getRandomStudent:(NSManagedObjectContext*) context;
+(void) deleteRandomStudent:(NSManagedObjectContext*) context;
+(NSUInteger) countForStudent:(NSManagedObjectContext*) context;
@end

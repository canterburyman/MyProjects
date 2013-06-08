//
//  Student.h
//  TestNSFetched
//
//  Created by Jane Ching on 12/04/12.
//  Copyright (c) 2012 UOW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MyClass;
@interface Student : NSManagedObject {
@private
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * uniqueId;

@property (nonatomic, retain) NSSet *belongTo;
@end

@interface Student (CoreDataGeneratedAccessors)

- (void)addBelongToObject:(MyClass *)value;
- (void)removeBelongToObject:(MyClass *)value;
- (void)addBelongTo:(NSSet *)values;
- (void)removeBelongTo:(NSSet *)values;



+(Student*) studentWithName:(NSString *)name InObjectContext:(NSManagedObjectContext*) context;
+(Student*) getRandomStudent:(NSManagedObjectContext*) context;
@end

//
//  Student.h
//  TestNSFetched
//
//  Created by Jane Ching on 12/04/12.
//  Copyright (c) 2012 UOW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Student : NSManagedObject {
@private
}

@property (nonatomic, retain) NSString * name;



+(Student*) studentWithName:(NSString *)name InObjectContext:(NSManagedObjectContext*) context;
+(Student*) getRandomStudent:(NSManagedObjectContext*) context;
@end

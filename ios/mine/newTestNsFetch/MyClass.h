//
//  MyClass.h
//  TestNSFetched
//
//  Created by Xinjun Email on 16/06/12.
//  Copyright (c) 2012 UOW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Student;

@interface MyClass : NSManagedObject

@property (nonatomic, retain) NSString * classId;
@property (nonatomic, retain) Student *students;
@property (nonatomic, retain) NSString * myClassName;




+(MyClass*) classWithName:(NSString *)name InObjectContext:(NSManagedObjectContext*) context;

@end

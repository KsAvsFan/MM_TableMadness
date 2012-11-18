//
//  MMClass.h
//  MMTableMadness
//
//  Created by Don Bora on 11/7/12.
//  Copyright (c) 2012 Don Bora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MMStudent;

@interface MMClass : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *students;
@end

@interface MMClass (CoreDataGeneratedAccessors)

- (void)addStudentsObject:(MMStudent *)value;
- (void)removeStudentsObject:(MMStudent *)value;
- (void)addStudents:(NSSet *)values;
- (void)removeStudents:(NSSet *)values;

@end

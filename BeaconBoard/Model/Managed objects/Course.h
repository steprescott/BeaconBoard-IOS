//
//  Course.h
//  BeaconBoard
//
//  Created by Ste Prescott on 08/02/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Lecturer, Module, Student;

@interface Course : NSManagedObject

@property (nonatomic, retain) NSString * courseID;
@property (nonatomic, retain) NSNumber * hasBeenUpdated;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *students;
@property (nonatomic, retain) NSSet *lecturers;
@property (nonatomic, retain) NSSet *modules;
@end

@interface Course (CoreDataGeneratedAccessors)

- (void)addStudentsObject:(Student *)value;
- (void)removeStudentsObject:(Student *)value;
- (void)addStudents:(NSSet *)values;
- (void)removeStudents:(NSSet *)values;

- (void)addLecturersObject:(Lecturer *)value;
- (void)removeLecturersObject:(Lecturer *)value;
- (void)addLecturers:(NSSet *)values;
- (void)removeLecturers:(NSSet *)values;

- (void)addModulesObject:(Module *)value;
- (void)removeModulesObject:(Module *)value;
- (void)addModules:(NSSet *)values;
- (void)removeModules:(NSSet *)values;

@end

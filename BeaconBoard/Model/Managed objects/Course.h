//
//  Course.h
//  BeaconBoard
//
//  Created by Ste Prescott on 07/02/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Lecturer, Lesson, Student;

@interface Course : NSManagedObject

@property (nonatomic, retain) NSString * courseID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * hasBeenUpdated;
@property (nonatomic, retain) NSSet *lecturers;
@property (nonatomic, retain) NSSet *lessons;
@property (nonatomic, retain) NSSet *students;
@end

@interface Course (CoreDataGeneratedAccessors)

- (void)addLecturersObject:(Lecturer *)value;
- (void)removeLecturersObject:(Lecturer *)value;
- (void)addLecturers:(NSSet *)values;
- (void)removeLecturers:(NSSet *)values;

- (void)addLessonsObject:(Lesson *)value;
- (void)removeLessonsObject:(Lesson *)value;
- (void)addLessons:(NSSet *)values;
- (void)removeLessons:(NSSet *)values;

- (void)addStudentsObject:(Student *)value;
- (void)removeStudentsObject:(Student *)value;
- (void)addStudents:(NSSet *)values;
- (void)removeStudents:(NSSet *)values;

@end

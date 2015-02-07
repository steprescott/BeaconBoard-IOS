//
//  Lesson.h
//  BeaconBoard
//
//  Created by Ste Prescott on 07/02/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Course, Resource, Session;

@interface Lesson : NSManagedObject

@property (nonatomic, retain) NSString * lessonID;
@property (nonatomic, retain) NSNumber * hasBeenUpdated;
@property (nonatomic, retain) NSSet *courses;
@property (nonatomic, retain) NSSet *reources;
@property (nonatomic, retain) NSSet *sessions;
@end

@interface Lesson (CoreDataGeneratedAccessors)

- (void)addCoursesObject:(Course *)value;
- (void)removeCoursesObject:(Course *)value;
- (void)addCourses:(NSSet *)values;
- (void)removeCourses:(NSSet *)values;

- (void)addReourcesObject:(Resource *)value;
- (void)removeReourcesObject:(Resource *)value;
- (void)addReources:(NSSet *)values;
- (void)removeReources:(NSSet *)values;

- (void)addSessionsObject:(Session *)value;
- (void)removeSessionsObject:(Session *)value;
- (void)addSessions:(NSSet *)values;
- (void)removeSessions:(NSSet *)values;

@end

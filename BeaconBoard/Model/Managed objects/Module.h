//
//  Module.h
//  BeaconBoard
//
//  Created by Ste Prescott on 08/02/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Course, Session;

@interface Module : NSManagedObject

@property (nonatomic, retain) NSString * moduleID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * moduleDescription;
@property (nonatomic, retain) NSNumber * termNumber;
@property (nonatomic, retain) NSNumber * hasBeenUpdated;
@property (nonatomic, retain) NSSet *courses;
@property (nonatomic, retain) NSSet *sessions;
@end

@interface Module (CoreDataGeneratedAccessors)

- (void)addCoursesObject:(Course *)value;
- (void)removeCoursesObject:(Course *)value;
- (void)addCourses:(NSSet *)values;
- (void)removeCourses:(NSSet *)values;

- (void)addSessionsObject:(Session *)value;
- (void)removeSessionsObject:(Session *)value;
- (void)addSessions:(NSSet *)values;
- (void)removeSessions:(NSSet *)values;

@end

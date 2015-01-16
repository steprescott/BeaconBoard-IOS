//
//  Lesson.h
//  BeaconBoard
//
//  Created by Ste Prescott on 16/01/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Course, Resource, Session;

@interface Lesson : NSManagedObject

@property (nonatomic, retain) NSString * lessonID;
@property (nonatomic, retain) NSSet *sessions;
@property (nonatomic, retain) Course *course;
@property (nonatomic, retain) NSSet *reources;
@end

@interface Lesson (CoreDataGeneratedAccessors)

- (void)addSessionsObject:(Session *)value;
- (void)removeSessionsObject:(Session *)value;
- (void)addSessions:(NSSet *)values;
- (void)removeSessions:(NSSet *)values;

- (void)addReourcesObject:(Resource *)value;
- (void)removeReourcesObject:(Resource *)value;
- (void)addReources:(NSSet *)values;
- (void)removeReources:(NSSet *)values;

@end

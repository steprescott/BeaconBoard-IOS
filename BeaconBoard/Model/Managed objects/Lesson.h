//
//  Lesson.h
//  BeaconBoard
//
//  Created by Ste Prescott on 08/02/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Resource, Session;

@interface Lesson : NSManagedObject

@property (nonatomic, retain) NSNumber * hasBeenUpdated;
@property (nonatomic, retain) NSString * lessonID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *sessions;
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

//
//  Session.h
//  BeaconBoard
//
//  Created by Ste Prescott on 07/02/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Attendance, Lecturer, Lesson, Room;

@interface Session : NSManagedObject

@property (nonatomic, retain) NSDate * scheduledEndDate;
@property (nonatomic, retain) NSDate * scheduledStartDate;
@property (nonatomic, retain) NSString * sessionID;
@property (nonatomic, retain) NSNumber * hasBeenUpdated;
@property (nonatomic, retain) NSSet *attendances;
@property (nonatomic, retain) NSSet *lecturers;
@property (nonatomic, retain) Lesson *lesson;
@property (nonatomic, retain) Room *room;
@end

@interface Session (CoreDataGeneratedAccessors)

- (void)addAttendancesObject:(Attendance *)value;
- (void)removeAttendancesObject:(Attendance *)value;
- (void)addAttendances:(NSSet *)values;
- (void)removeAttendances:(NSSet *)values;

- (void)addLecturersObject:(Lecturer *)value;
- (void)removeLecturersObject:(Lecturer *)value;
- (void)addLecturers:(NSSet *)values;
- (void)removeLecturers:(NSSet *)values;

@end

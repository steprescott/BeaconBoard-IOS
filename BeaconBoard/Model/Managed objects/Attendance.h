//
//  Attendance.h
//  BeaconBoard
//
//  Created by Ste Prescott on 07/02/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Session, Student;

@interface Attendance : NSManagedObject

@property (nonatomic, retain) NSString * attendanceID;
@property (nonatomic, retain) NSNumber * hasBeenUpdated;
@property (nonatomic, retain) Session *session;
@property (nonatomic, retain) Student *student;

@end

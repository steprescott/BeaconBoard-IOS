//
//  Attendance+Additions.h
//  BeaconBoard
//
//  Created by Ste Prescott on 03/02/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "Attendance.h"

@interface Attendance (Additions)

+ (void)importAttendances:(NSArray *)attendances intoContext:(NSManagedObjectContext *)context error:(NSError **)error;
+ (void)deleteAllInvalidAttendancesInContext:(NSManagedObjectContext *)context;

@end

//
//  Attendance+Additions.m
//  BeaconBoard
//
//  Created by Ste Prescott on 03/02/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "Attendance+Additions.h"
#import "ContextManager.h"

@implementation Attendance (Additions)

+ (void)importAttendances:(NSArray *)attendances intoContext:(NSManagedObjectContext *)context error:(NSError **)error
{
    [Attendance sqk_insertOrUpdate:attendances
                    uniqueModelKey:@"attendanceID"
                   uniqueRemoteKey:@"AttendanceID"
               propertySetterBlock:^(NSDictionary *dictionary, Attendance *managedObject) {
                   managedObject.attendanceID = ![dictionary[@"AttendanceID"] isEqual:[NSNull null]] ? dictionary[@"AttendanceID"] : nil;
                   
                   if(![dictionary[@"SessionID"] isEqual:[NSNull null]])
                   {
                       managedObject.session = [Session sqk_insertOrFetchWithKey:@"sessionID"
                                                                           value:dictionary[@"SessionID"]
                                                                         context:context
                                                                           error:error];
                   }
                   
                   if(![dictionary[@"StudentID"] isEqual:[NSNull null]])
                   {
                       managedObject.student = [Student sqk_insertOrFetchWithKey:@"userID"
                                                                           value:dictionary[@"StudentID"]
                                                                         context:context
                                                                           error:error];
                   }
                   
                   managedObject.hasBeenUpdated = @YES;
               }
                    privateContext:context
                             error:error];
}

+ (void)deleteAllInvalidAttendancesInContext:(NSManagedObjectContext *)context
{
    NSError *error;
    [Attendance sqk_deleteAllObjectsInContext:context withPredicate:[NSPredicate predicateWithFormat:@"hasBeenUpdated == NO"] error:&error];
    
    if(error)
    {
        NSLog(@"Error : %@", error.localizedDescription);
    }
}

@end

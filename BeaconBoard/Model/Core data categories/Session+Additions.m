//
//  Session+Additions.m
//  BeaconBoard
//
//  Created by Ste Prescott on 16/01/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "Session+Additions.h"
#import "ContextManager.h"

@implementation Session (Additions)

+ (void)importSessions:(NSArray *)sessions intoContext:(NSManagedObjectContext *)context error:(NSError **)error
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone systemTimeZone];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS";
    
    [Session sqk_insertOrUpdate:sessions
                 uniqueModelKey:@"sessionID"
                uniqueRemoteKey:@"SessionID"
            propertySetterBlock:^(NSDictionary *dictionary, Session *managedObject) {
                managedObject.sessionID = ![dictionary[@"SessionID"] isEqual:[NSNull null]] ? dictionary[@"SessionID"] : nil;
                managedObject.scheduledStartDate = ![dictionary[@"ScheduledStartDate"] isEqual:[NSNull null]] ? [dateFormatter dateFromString:dictionary[@"ScheduledStartDate"]] : nil;
                managedObject.scheduledEndDate = ![dictionary[@"ScheduledEndDate"] isEqual:[NSNull null]] ? [dateFormatter dateFromString:dictionary[@"ScheduledEndDate"]] : nil;
                
                if(![dictionary[@"RoomID"] isEqual:[NSNull null]])
                {
                    managedObject.room = [Room sqk_insertOrFetchWithKey:@"roomID"
                                                                  value:dictionary[@"RoomID"]
                                                                context:context
                                                                  error:error];
                }
                
                if(![dictionary[@"ModuleID"] isEqual:[NSNull null]])
                {
                    managedObject.module = [Module sqk_insertOrFetchWithKey:@"moduleID"
                                                                      value:dictionary[@"ModuleID"]
                                                                    context:context
                                                                      error:error];
                }
                
                if(![dictionary[@"LessonID"] isEqual:[NSNull null]])
                {
                    managedObject.lesson = [Lesson sqk_insertOrFetchWithKey:@"lessonID"
                                                                      value:dictionary[@"LessonID"]
                                                                    context:context
                                                                      error:error];
                }
                
                [dictionary[@"LecturerIDs"] enumerateObjectsUsingBlock:^(NSString *lecturerID, NSUInteger idx, BOOL *stop) {
                    [managedObject addLecturersObject:[Lecturer sqk_insertOrFetchWithKey:@"userID"
                                                                                   value:lecturerID
                                                                                 context:context
                                                                                   error:error]];
                }];
                
                [dictionary[@"AttendanceIDs"] enumerateObjectsUsingBlock:^(NSString *attendanceID, NSUInteger idx, BOOL *stop) {
                    [managedObject addAttendancesObject:[Attendance sqk_insertOrFetchWithKey:@"attendanceID"
                                                                                       value:attendanceID
                                                                                     context:context
                                                                                       error:error]];
                }];
                
                managedObject.hasBeenUpdated = @YES;
            }
                 privateContext:context
                          error:error];
}

+ (Session *)sessionWithSessionID:(NSString *)sessionID inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [Session sqk_fetchRequest];
    request.predicate = [NSPredicate predicateWithFormat:@"sessionID == %@", sessionID];
    
    NSArray *sessions = [context executeFetchRequest:request error:nil];
    
    return [sessions lastObject];
}

+ (void)deleteAllInvalidSessionInContext:(NSManagedObjectContext *)context
{
    NSError *error;
    [Session sqk_deleteAllObjectsInContext:context withPredicate:[NSPredicate predicateWithFormat:@"hasBeenUpdated == NO"] error:&error];
    
    if(error)
    {
        NSLog(@"Error : %@", error.localizedDescription);
    }
}

@end

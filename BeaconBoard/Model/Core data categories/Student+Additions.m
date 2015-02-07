//
//  Student+Additions.m
//  BeaconBoard
//
//  Created by Ste Prescott on 03/02/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "Student+Additions.h"
#import "ContextManager.h"

@implementation Student (Additions)

+ (void)importStudents:(NSArray *)students intoContext:(NSManagedObjectContext *)context error:(NSError **)error
{
    [Student sqk_insertOrUpdate:students
                 uniqueModelKey:@"userID"
                uniqueRemoteKey:@"UserID"
            propertySetterBlock:^(NSDictionary *dictionary, Student *managedObject) {
                managedObject.userID = ![dictionary[@"UserID"] isEqual:[NSNull null]] ? dictionary[@"UserID"] : nil;
                managedObject.username = ![dictionary[@"Username"] isEqual:[NSNull null]] ? dictionary[@"Username"] : nil;
                managedObject.firstName = ![dictionary[@"FirstName"] isEqual:[NSNull null]] ? dictionary[@"FirstName"] : nil;
                managedObject.otherNames = ![dictionary[@"OtherNames"] isEqual:[NSNull null]] ? dictionary[@"OtherNames"] : nil;
                managedObject.lastName = ![dictionary[@"LastName"] isEqual:[NSNull null]] ? dictionary[@"LastName"] : nil;
                managedObject.emailAddress = ![dictionary[@"EmailAddress"] isEqual:[NSNull null]] ? dictionary[@"EmailAddress"] : nil;
                
                if(![dictionary[@"RoleID"] isEqual:[NSNull null]])
                {
                    managedObject.role = [Role sqk_insertOrFetchWithKey:@"roleID"
                                                                  value:dictionary[@"RoleID"]
                                                                context:context
                                                                  error:error];
                }
                
                [dictionary[@"CourseIDs"] enumerateObjectsUsingBlock:^(NSString *courseID, NSUInteger idx, BOOL *stop) {
                    [managedObject addCoursesObject:[Course sqk_insertOrFetchWithKey:@"courseID"
                                                                               value:courseID
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

+ (void)deleteAllInvalidStudentsInContext:(NSManagedObjectContext *)context
{
    NSError *error;
    [Student sqk_deleteAllObjectsInContext:context withPredicate:[NSPredicate predicateWithFormat:@"hasBeenUpdated == NO"] error:&error];
    
    if(error)
    {
        NSLog(@"Error : %@", error.localizedDescription);
    }
}

@end

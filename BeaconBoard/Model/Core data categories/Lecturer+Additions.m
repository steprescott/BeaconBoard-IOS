//
//  Lecturer+Additions.m
//  BeaconBoard
//
//  Created by Ste Prescott on 06/02/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "Lecturer+Additions.h"
#import "ContextManager.h"

@implementation Lecturer (Additions)

+ (void)importLecturers:(NSArray *)lecturers intoContext:(NSManagedObjectContext *)context error:(NSError **)error
{
    [Lecturer sqk_insertOrUpdate:lecturers
                  uniqueModelKey:@"userID"
                 uniqueRemoteKey:@"UserID"
             propertySetterBlock:^(NSDictionary *dictionary, Lecturer *managedObject) {

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
                 
                 [dictionary[@"SessionIDs"] enumerateObjectsUsingBlock:^(NSString *sessionID, NSUInteger idx, BOOL *stop) {
                     [managedObject addSessionsObject:[Session sqk_insertOrFetchWithKey:@"sessionID"
                                                                                  value:sessionID
                                                                                context:context
                                                                                  error:error]];
                 }];
                 
                 managedObject.hasBeenUpdated = @YES;
             }
                  privateContext:context
                           error:error];
}

+ (void)deleteAllInvalidLecturersInContext:(NSManagedObjectContext *)context
{
    NSError *error;
    [Lecturer sqk_deleteAllObjectsInContext:context withPredicate:[NSPredicate predicateWithFormat:@"hasBeenUpdated == NO"] error:&error];
    
    if(error)
    {
        NSLog(@"Error : %@", error.localizedDescription);
    }
}

@end

//
//  Course+Additions.m
//  BeaconBoard
//
//  Created by Ste Prescott on 16/01/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "Course+Additions.h"
#import "ContextManager.h"

@implementation Course (Additions)

+ (void)importCources:(NSArray *)cources intoContext:(NSManagedObjectContext *)context error:(NSError **)error
{
    [Course sqk_insertOrUpdate:cources
                uniqueModelKey:@"courseID"
               uniqueRemoteKey:@"CourseID"
           propertySetterBlock:^(NSDictionary *dictionary, Course *managedObject) {
               managedObject.courseID = ![dictionary[@"CourseID"] isEqual:[NSNull null]] ? dictionary[@"CourseID"] : nil;
               managedObject.name = ![dictionary[@"Name"] isEqual:[NSNull null]] ? dictionary[@"Name"] : nil;
               
               [dictionary[@"LessonIDs"] enumerateObjectsUsingBlock:^(NSString *lessonID, NSUInteger idx, BOOL *stop) {
                   [managedObject addLessonsObject:[Lesson sqk_insertOrFetchWithKey:@"lessonID"
                                                                              value:lessonID
                                                                            context:context
                                                                              error:error]];
               }];
               
               [dictionary[@"StudentIDs"] enumerateObjectsUsingBlock:^(NSString *studentID, NSUInteger idx, BOOL *stop) {
                   [managedObject addStudentsObject:[Student sqk_insertOrFetchWithKey:@"userID"
                                                                                value:studentID
                                                                              context:context
                                                                                error:error]];
               }];
               
               [dictionary[@"LecturerIDs"] enumerateObjectsUsingBlock:^(NSString *lecturerID, NSUInteger idx, BOOL *stop) {
                   [managedObject addLecturersObject:[Lecturer sqk_insertOrFetchWithKey:@"userID"
                                                                                  value:lecturerID
                                                                                context:context
                                                                                  error:error]];
               }];
               
               managedObject.hasBeenUpdated = @YES;
           }
                privateContext:context
                         error:error];
}

+ (void)deleteAllInvalidCoursesInContext:(NSManagedObjectContext *)context
{
    NSError *error;
    [Course sqk_deleteAllObjectsInContext:context withPredicate:[NSPredicate predicateWithFormat:@"hasBeenUpdated == NO"] error:&error];
    
    if(error)
    {
        NSLog(@"Error : %@", error.localizedDescription);
    }
}

@end

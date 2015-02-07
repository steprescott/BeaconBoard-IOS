//
//  Lesson+Additions.m
//  BeaconBoard
//
//  Created by Ste Prescott on 16/01/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "Lesson+Additions.h"
#import "ContextManager.h"

@implementation Lesson (Additions)

+ (void)importLessons:(NSArray *)lessons intoContext:(NSManagedObjectContext *)context error:(NSError **)error
{
    [Lesson sqk_insertOrUpdate:lessons
                uniqueModelKey:@"lessonID"
               uniqueRemoteKey:@"LessonID"
           propertySetterBlock:^(NSDictionary *dictionary, Lesson *managedObject) {
               managedObject.lessonID = ![dictionary[@"LessonID"] isEqual:[NSNull null]] ? dictionary[@"LessonID"] : nil;
               
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
               
               [dictionary[@"ResourceIDs"] enumerateObjectsUsingBlock:^(NSString *resourceID, NSUInteger idx, BOOL *stop) {
                   [managedObject addReourcesObject:[Resource sqk_insertOrFetchWithKey:@"resourceID"
                                                                                 value:resourceID
                                                                               context:context
                                                                                 error:error]];
               }];
               
               managedObject.hasBeenUpdated = @YES;
           }
                privateContext:context
                         error:error];
}

+ (void)deleteAllInvalidLessonsInContext:(NSManagedObjectContext *)context
{
    NSError *error;
    [Lesson sqk_deleteAllObjectsInContext:context withPredicate:[NSPredicate predicateWithFormat:@"hasBeenUpdated == NO"] error:&error];
    
    if(error)
    {
        NSLog(@"Error : %@", error.localizedDescription);
    }
}

@end

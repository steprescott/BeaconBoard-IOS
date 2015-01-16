//
//  Lesson+Addtions.m
//  BeaconBoard
//
//  Created by Ste Prescott on 16/01/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "Lesson+Addtions.h"
#import "ContextManager.h"

@implementation Lesson (Addtions)

+ (void)importLessons:(NSArray *)lessons intoContext:(NSManagedObjectContext *)context error:(NSError **)error
{
    [Lesson sqk_insertOrUpdate:lessons
                uniqueModelKey:@"lessonID"
               uniqueRemoteKey:@"LessonID"
           propertySetterBlock:^(NSDictionary *dictionary, Lesson *managedObject) {
               managedObject.lessonID = dictionary[@"LessonID"];
               
               managedObject.course = [Course sqk_insertOrFetchWithKey:@"courseID"
                                                                 value:dictionary[@"CourseID"]
                                                               context:context
                                                                 error:error];
               
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
           }
                privateContext:context
                         error:error];
}

@end

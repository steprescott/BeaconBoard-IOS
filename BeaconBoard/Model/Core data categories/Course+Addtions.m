//
//  Course+Addtions.m
//  BeaconBoard
//
//  Created by Ste Prescott on 16/01/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "Course+Addtions.h"
#import "ContextManager.h"

@implementation Course (Addtions)

+ (void)importCources:(NSArray *)cources intoContext:(NSManagedObjectContext *)context error:(NSError **)error
{
    [Course sqk_insertOrUpdate:cources
                uniqueModelKey:@"courseID"
               uniqueRemoteKey:@"CourseID"
           propertySetterBlock:^(NSDictionary *dictionary, Course *managedObject) {
               managedObject.courseID = dictionary[@"CourceID"];
               managedObject.name = dictionary[@"Name"];
               [dictionary[@"LessonIDs"] enumerateObjectsUsingBlock:^(NSString *lessonID, NSUInteger idx, BOOL *stop) {
                   [managedObject addLessonsObject:[Lesson sqk_insertOrFetchWithKey:@"lessonID"
                                                                              value:lessonID
                                                                            context:context
                                                                              error:error]];
               }];
           }
                privateContext:context
                         error:error];
}

@end

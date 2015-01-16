//
//  Resource+Addtions.m
//  BeaconBoard
//
//  Created by Ste Prescott on 16/01/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "Resource+Addtions.h"
#import "ContextManager.h"

@implementation Resource (Addtions)

+ (void)importResources:(NSArray *)resources intoContext:(NSManagedObjectContext *)context error:(NSError **)error
{
    [Resource sqk_insertOrUpdate:resources
                uniqueModelKey:@"resourceID"
               uniqueRemoteKey:@"ResourceID"
           propertySetterBlock:^(NSDictionary *dictionary, Resource *managedObject) {
               managedObject.resourceID = dictionary[@"ResourceID"];
               managedObject.name = dictionary[@"Name"];
               managedObject.resourceDescription = dictionary[@"Description"];
               managedObject.urlString = dictionary[@"URLString"];
               managedObject.resourceType = [ResourceType sqk_insertOrFetchWithKey:@"resourceTypeID"
                                                                             value:dictionary[@"ResourceTypeID"]
                                                                           context:context
                                                                             error:error];
               
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

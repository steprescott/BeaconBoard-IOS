//
//  Resource+Additions.m
//  BeaconBoard
//
//  Created by Ste Prescott on 16/01/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "Resource+Additions.h"
#import "ContextManager.h"

@implementation Resource (Additions)

+ (void)importResources:(NSArray *)resources intoContext:(NSManagedObjectContext *)context error:(NSError **)error
{
    [Resource sqk_insertOrUpdate:resources
                  uniqueModelKey:@"resourceID"
                 uniqueRemoteKey:@"ResourceID"
             propertySetterBlock:^(NSDictionary *dictionary, Resource *managedObject) {
                 managedObject.resourceID = ![dictionary[@"ResourceID"] isEqual:[NSNull null]] ? dictionary[@"ResourceID"] : nil;
                 managedObject.name = ![dictionary[@"Name"] isEqual:[NSNull null]] ? dictionary[@"Name"] : nil;
                 managedObject.resourceDescription = ![dictionary[@"Description"] isEqual:[NSNull null]] ? dictionary[@"Description"] : nil;
                 managedObject.urlString = ![dictionary[@"URLString"] isEqual:[NSNull null]] ? dictionary[@"URLString"] : nil;
                 
                 if(![dictionary[@"ResourceTypeID"] isEqual:[NSNull null]])
                 {
                     managedObject.resourceType = [ResourceType sqk_insertOrFetchWithKey:@"resourceTypeID"
                                                                                   value:dictionary[@"ResourceTypeID"]
                                                                                 context:context
                                                                                   error:error];
                 }
                 
                 [dictionary[@"LessonIDs"] enumerateObjectsUsingBlock:^(NSString *lessonID, NSUInteger idx, BOOL *stop) {
                     [managedObject addLessonsObject:[Lesson sqk_insertOrFetchWithKey:@"lessonID"
                                                                                value:lessonID
                                                                              context:context
                                                                                error:error]];
                 }];
                 
                 managedObject.hasBeenUpdated = @YES;
             }
                  privateContext:context
                           error:error];
}

+ (void)deleteAllInvalidResourcesInContext:(NSManagedObjectContext *)context
{
    NSError *error;
    [Resource sqk_deleteAllObjectsInContext:context withPredicate:[NSPredicate predicateWithFormat:@"hasBeenUpdated == NO"] error:&error];
    
    if(error)
    {
        NSLog(@"Error : %@", error.localizedDescription);
    }
}

@end

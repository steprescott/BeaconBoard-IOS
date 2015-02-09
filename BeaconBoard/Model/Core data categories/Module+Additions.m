//
//  Module+Additions.m
//  BeaconBoard
//
//  Created by Ste Prescott on 08/02/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "Module+Additions.h"
#import "ContextManager.h"

@implementation Module (Additions)

+ (void)importModules:(NSArray *)modules intoContext:(NSManagedObjectContext *)context error:(NSError **)error
{
    [Module sqk_insertOrUpdate:modules
                uniqueModelKey:@"moduleID"
               uniqueRemoteKey:@"ModuleID"
           propertySetterBlock:^(NSDictionary *dictionary, Module *managedObject) {
               managedObject.moduleID = ![dictionary[@"ModuleID"] isEqual:[NSNull null]] ? dictionary[@"ModuleID"] : nil;
               managedObject.name = ![dictionary[@"Name"] isEqual:[NSNull null]] ? dictionary[@"Name"] : nil;
               managedObject.moduleDescription = ![dictionary[@"Description"] isEqual:[NSNull null]] ? dictionary[@"Description"] : nil;
               managedObject.termNumber = ![dictionary[@"TermNumber"] isEqual:[NSNull null]] ? dictionary[@"TermNumber"] : nil;
               
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

+ (void)deleteAllInvalidModulesInContext:(NSManagedObjectContext *)context
{
    NSError *error;
    [Module sqk_deleteAllObjectsInContext:context withPredicate:[NSPredicate predicateWithFormat:@"hasBeenUpdated == NO"] error:&error];
    
    if(error)
    {
        NSLog(@"Error : %@", error.localizedDescription);
    }
}

@end

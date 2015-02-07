//
//  ResourceType+Additions.m
//  BeaconBoard
//
//  Created by Ste Prescott on 16/01/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "ResourceType+Additions.h"
#import "ContextManager.h"

@implementation ResourceType (Additions)

+ (void)importResourceTypes:(NSArray *)resourceTypes intoContext:(NSManagedObjectContext *)context error:(NSError **)error
{
    [ResourceType sqk_insertOrUpdate:resourceTypes
                      uniqueModelKey:@"resourceTypeID"
                     uniqueRemoteKey:@"ResourceTypeID"
                 propertySetterBlock:^(NSDictionary *dictionary, ResourceType *managedObject) {
                     managedObject.resourceTypeID = ![dictionary[@"ResourceTypeID"] isEqual:[NSNull null]] ? dictionary[@"ResourceTypeID"] : nil;
                     managedObject.name = ![dictionary[@"Name"] isEqual:[NSNull null]] ? dictionary[@"Name"] : nil;
                     managedObject.resourceTypeDescription = ![dictionary[@"Description"] isEqual:[NSNull null]] ? dictionary[@"Description"] : nil;
                     
                     [dictionary[@"ResourceIDs"] enumerateObjectsUsingBlock:^(NSString *resourceID, NSUInteger idx, BOOL *stop) {
                         [managedObject addResourcesObject:[Resource sqk_insertOrFetchWithKey:@"resourceID"
                                                                                        value:resourceID
                                                                                      context:context
                                                                                        error:error]];
                     }];
                     
                     managedObject.hasBeenUpdated = @YES;
                 }
                      privateContext:context
                               error:error];
}

+ (void)deleteAllInvalidResourceTypesInContext:(NSManagedObjectContext *)context
{
    NSError *error;
    [ResourceType sqk_deleteAllObjectsInContext:context withPredicate:[NSPredicate predicateWithFormat:@"hasBeenUpdated == NO"] error:&error];
    
    if(error)
    {
        NSLog(@"Error : %@", error.localizedDescription);
    }
}

@end

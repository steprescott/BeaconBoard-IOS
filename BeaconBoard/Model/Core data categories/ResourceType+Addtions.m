//
//  ResourceType+Addtions.m
//  BeaconBoard
//
//  Created by Ste Prescott on 16/01/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "ResourceType+Addtions.h"
#import "ContextManager.h"

@implementation ResourceType (Addtions)

+ (void)importResourceTypes:(NSArray *)resourceTypes intoContext:(NSManagedObjectContext *)context error:(NSError **)error
{
    [ResourceType sqk_insertOrUpdate:resourceTypes
                      uniqueModelKey:@"resourceTypeID"
                     uniqueRemoteKey:@"ResourceTypeID"
                 propertySetterBlock:^(NSDictionary *dictionary, ResourceType *managedObject) {
                     managedObject.resourceTypeID = dictionary[@"ResourceTypeID"];
                     managedObject.name = dictionary[@"Name"];
                     managedObject.resourceTypeDescription = dictionary[@"Description"];
                     
                     [dictionary[@"ResourceIDs"] enumerateObjectsUsingBlock:^(NSString *resourceID, NSUInteger idx, BOOL *stop) {
                         [managedObject addResourcesObject:[Resource sqk_insertOrFetchWithKey:@"resourceID"
                                                                                        value:resourceID
                                                                                      context:context
                                                                                        error:error]];
                     }];
                 }
                      privateContext:context
                               error:error];
}

@end

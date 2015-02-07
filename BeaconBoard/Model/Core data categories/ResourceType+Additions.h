//
//  ResourceType+Additions.h
//  BeaconBoard
//
//  Created by Ste Prescott on 16/01/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "ResourceType.h"

@interface ResourceType (Additions)

+ (void)importResourceTypes:(NSArray *)resourceTypes intoContext:(NSManagedObjectContext *)context error:(NSError **)error;
+ (void)deleteAllInvalidResourceTypesInContext:(NSManagedObjectContext *)context;

@end

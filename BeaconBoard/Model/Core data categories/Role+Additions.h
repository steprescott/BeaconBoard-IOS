//
//  Role+Additions.h
//  BeaconBoard
//
//  Created by Ste Prescott on 06/02/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "Role.h"

@interface Role (Additions)

+ (void)importRoles:(NSArray *)roles intoContext:(NSManagedObjectContext *)context error:(NSError **)error;
+ (void)deleteAllInvalidRolesInContext:(NSManagedObjectContext *)context;

@end

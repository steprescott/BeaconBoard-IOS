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
+ (Role *)roleWithID:(NSString *)roleID inContext:(NSManagedObjectContext *)context;
+ (void)deleteAllInvalidRolesInContext:(NSManagedObjectContext *)context;

- (BOOL)isLecturerRole;
- (BOOL)isStudentRole;

@end

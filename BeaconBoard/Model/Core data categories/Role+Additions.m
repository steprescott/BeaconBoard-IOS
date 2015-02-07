//
//  Role+Additions.m
//  BeaconBoard
//
//  Created by Ste Prescott on 06/02/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "Role+Additions.h"
#import "ContextManager.h"

@implementation Role (Additions)

+ (void)importRoles:(NSArray *)roles intoContext:(NSManagedObjectContext *)context error:(NSError **)error
{
    [Role sqk_insertOrUpdate:roles
              uniqueModelKey:@"roleID"
             uniqueRemoteKey:@"RoleID"
         propertySetterBlock:^(NSDictionary *dictionary, Role *managedObject) {
             managedObject.roleID = ![dictionary[@"RoleID"] isEqual:[NSNull null]] ? dictionary[@"RoleID"] : nil;
             managedObject.name = ![dictionary[@"Name"] isEqual:[NSNull null]] ? dictionary[@"Name"] : nil;

             managedObject.hasBeenUpdated = @YES;
         }
              privateContext:context
                       error:error];
}

+ (Role *)roleWithID:(NSString *)roleID inContext:(NSManagedObjectContext *)context
{
    NSError *error;
    NSFetchRequest *request = [Role sqk_fetchRequest];
    request.predicate = [NSPredicate predicateWithFormat:@"roleID = %@", roleID];
    NSArray *roles = [context executeFetchRequest:request error:&error];
    
    if(error)
    {
        NSLog(@"Error %@", error);
        return nil;
    }
    
    if(roles.count > 1)
    {
        NSLog(@"More than one Role with the ID of '%@'. Returning last object.", roleID);
    }
    
    return [roles lastObject];
}

- (BOOL)isLecturerRole
{
    return [self.name isEqualToString:@"Lecturer"];
}

- (BOOL)isStudentRole
{
    return [self.name isEqualToString:@"Student"];
}

+ (void)deleteAllInvalidRolesInContext:(NSManagedObjectContext *)context
{
    NSError *error;
    [Role sqk_deleteAllObjectsInContext:context withPredicate:[NSPredicate predicateWithFormat:@"hasBeenUpdated == NO"] error:&error];
    
    if(error)
    {
        NSLog(@"Error : %@", error.localizedDescription);
    }
}

@end

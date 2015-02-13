//
//  User+Additions.m
//  BeaconBoard
//
//  Created by Ste Prescott on 07/02/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "User+Additions.h"
#import "ContextManager.h"

@implementation User (Additions)

+ (void)setActiveUserToUserWithID:(NSString *)userID inContext:(NSManagedObjectContext *)context
{
    NSError *error;
    
    //Make sure any previous active users are set to inactive
    NSArray *allUsers = [context executeFetchRequest:[User sqk_fetchRequest]
                                               error:&error];
    [allUsers makeObjectsPerformSelector:@selector(setIsActiveUser:) withObject:@NO];
    
    //Set the new User to active
    User *activeUser = [User userWithID:userID inContext:context];
    activeUser.isActiveUser = @YES;
    
    [context save:&error];
    
    if(error)
    {
        NSLog(@"Error %@", error);
    }
}

+ (User *)userWithID:(NSString *)userID inContext:(NSManagedObjectContext *)context
{
    NSError *error;
    NSFetchRequest *request = [User sqk_fetchRequest];
    request.predicate = [NSPredicate predicateWithFormat:@"userID == %@", userID];
    
    NSArray *users = [context executeFetchRequest:request error:&error];
    
    if(error)
    {
        NSLog(@"Error %@", error);
        return nil;
    }
    
    if(users.count > 1)
    {
        NSLog(@"More than one user with the ID of %@. Returning last object.", userID);
    }
    
    return [users lastObject];
}

+ (User *)activeUserInContext:(NSManagedObjectContext *)context
{
    NSError *error;
    NSFetchRequest *request = [User sqk_fetchRequest];
    request.predicate = [NSPredicate predicateWithFormat:@"isActiveUser == YES"];
    
    NSArray *activeUsers = [context executeFetchRequest:request error:&error];
    
    if(error)
    {
        NSLog(@"Error %@", error);
        return nil;
    }
    
    if(activeUsers.count > 1)
    {
        NSLog(@"More than one active user. Returning last object.");
    }

    return [activeUsers lastObject];
}

- (BOOL)isLecturer
{
    return [self.role.name isEqualToString:@"Lecturer"];
}

- (BOOL)isStudent
{
    return [self.role.name isEqualToString:@"Student"];
}

- (NSString *)fullName
{
    if(self.otherNames)
    {
        return [NSString stringWithFormat:@"%@ %@ %@", self.firstName, self.otherNames, self.lastName];
    }
    else
    {
        return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
    }
}

@end

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

@end

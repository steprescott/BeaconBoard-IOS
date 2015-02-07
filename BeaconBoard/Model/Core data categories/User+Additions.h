//
//  User+Additions.h
//  BeaconBoard
//
//  Created by Ste Prescott on 07/02/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "User.h"

@interface User (Additions)

+ (void)setActiveUserToUserWithID:(NSString *)userID inContext:(NSManagedObjectContext *)context;
+ (User *)userWithID:(NSString *)userID inContext:(NSManagedObjectContext *)context;
+ (User *)activeUserInContext:(NSManagedObjectContext *)context;

- (BOOL)isLecturer;
- (BOOL)isStudent;

@end

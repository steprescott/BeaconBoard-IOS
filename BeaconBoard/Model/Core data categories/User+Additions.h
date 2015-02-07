//
//  User+Additions.h
//  BeaconBoard
//
//  Created by Ste Prescott on 07/02/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "User.h"

@interface User (Additions)

+ (User *)activeUserInContext:(NSManagedObjectContext *)context;

@end

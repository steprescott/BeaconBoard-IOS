//
//  Session+Additions.h
//  BeaconBoard
//
//  Created by Ste Prescott on 16/01/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "Session.h"

@interface Session (Additions)

+ (void)importSessions:(NSArray *)sessions intoContext:(NSManagedObjectContext *)context error:(NSError **)error;
+ (Session *)sessionWithSessionID:(NSString *)sessionID inContext:(NSManagedObjectContext *)context;
+ (void)deleteAllInvalidSessionInContext:(NSManagedObjectContext *)context;

@end

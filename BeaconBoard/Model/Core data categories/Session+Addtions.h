//
//  Session+Addtions.h
//  BeaconBoard
//
//  Created by Ste Prescott on 16/01/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "Session.h"

@interface Session (Addtions)

+ (void)importSessions:(NSArray *)sessions intoContext:(NSManagedObjectContext *)context error:(NSError **)error;

@end

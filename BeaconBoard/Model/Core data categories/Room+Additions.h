//
//  Room+Additions.h
//  BeaconBoard
//
//  Created by Ste Prescott on 15/01/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "Room.h"

@interface Room (Additions)

+ (void)importRooms:(NSArray *)rooms intoContext:(NSManagedObjectContext *)context error:(NSError **)error;
+ (void)deleteAllInvalidRoomsInContext:(NSManagedObjectContext *)context;

@end

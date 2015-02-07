//
//  Room+Additions.m
//  BeaconBoard
//
//  Created by Ste Prescott on 15/01/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "Room+Additions.h"
#import "ContextManager.h"

@implementation Room (Additions)

+ (void)importRooms:(NSArray *)rooms intoContext:(NSManagedObjectContext *)context error:(NSError **)error
{
    [Room sqk_insertOrUpdate:rooms
              uniqueModelKey:@"roomID"
             uniqueRemoteKey:@"RoomID"
         propertySetterBlock:^(NSDictionary *dictionary, Room *managedObject) {
             managedObject.roomID = ![dictionary[@"RoomID"] isEqual:[NSNull null]] ? dictionary[@"RoomID"] : nil;
             managedObject.number = ![dictionary[@"Number"] isEqual:[NSNull null]] ? dictionary[@"Number"] : nil;
             
             [dictionary[@"BeaconIDs"] enumerateObjectsUsingBlock:^(NSString *beaconID, NSUInteger idx, BOOL *stop) {
                 [managedObject addBeaconsObject:[Beacon sqk_insertOrFetchWithKey:@"beaconID"
                                                                            value:beaconID
                                                                          context:context
                                                                            error:error]];
             }];
             
             [dictionary[@"SessionIDs"] enumerateObjectsUsingBlock:^(NSString *sessionID, NSUInteger idx, BOOL *stop) {
                 [managedObject addSessionsObject:[Session sqk_insertOrFetchWithKey:@"sessionID"
                                                                              value:sessionID
                                                                            context:context
                                                                              error:error]];
             }];
             
             managedObject.hasBeenUpdated = @YES;
         }
              privateContext:context
                       error:error];
}

+ (void)deleteAllInvalidRoomsInContext:(NSManagedObjectContext *)context
{
    NSError *error;
    [Room sqk_deleteAllObjectsInContext:context withPredicate:[NSPredicate predicateWithFormat:@"hasBeenUpdated == NO"] error:&error];
    
    if(error)
    {
        NSLog(@"Error : %@", error.localizedDescription);
    }
}

@end

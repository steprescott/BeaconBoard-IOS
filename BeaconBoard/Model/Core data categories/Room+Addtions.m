//
//  Room+Addtions.m
//  BeaconBoard
//
//  Created by Ste Prescott on 15/01/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "Room+Addtions.h"
#import "ContextManager.h"

@implementation Room (Addtions)

+ (void)importRooms:(NSArray *)rooms intoContext:(NSManagedObjectContext *)context error:(NSError **)error
{
    [Room sqk_insertOrUpdate:rooms
                uniqueModelKey:@"roomID"
               uniqueRemoteKey:@"RoomID"
           propertySetterBlock:^(NSDictionary *dictionary, Room *managedObject) {
               managedObject.roomID = dictionary[@"RoomID"];
               managedObject.number = dictionary[@"Number"];
               
               [dictionary[@"BeaconIDs"] enumerateObjectsUsingBlock:^(NSString *beaconID, NSUInteger idx, BOOL *stop) {
                   [managedObject addBeaconsObject:[Beacon sqk_insertOrFetchWithKey:@"beaconID"
                                                                              value:beaconID
                                                                            context:context
                                                                              error:error]];
               }];
           }
                privateContext:context
                         error:error];
}

@end

//
//  Beacon+Addtions.m
//  BeaconBoard
//
//  Created by Ste Prescott on 15/01/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "Beacon+Addtions.h"
#import "ContextManager.h"

@implementation Beacon (Addtions)

+ (void)importBeacons:(NSArray *)beacons intoContext:(NSManagedObjectContext *)context error:(NSError **)error
{
    [Beacon sqk_insertOrUpdate:beacons
                uniqueModelKey:@"beaconID"
               uniqueRemoteKey:@"BeaconID"
           propertySetterBlock:^(NSDictionary *dictionary, Beacon *managedObject) {
               managedObject.beaconID = dictionary[@"BeaconID"];
               managedObject.major = dictionary[@"Major"];
               managedObject.minor = dictionary[@"Minor"];
               managedObject.room = [Room sqk_insertOrFetchWithKey:@"roomID"
                                                             value:dictionary[@"RoomID"]
                                                           context:context
                                                             error:error];
           }
                privateContext:context
                         error:error];
}

@end

//
//  Beacon+Additions.m
//  BeaconBoard
//
//  Created by Ste Prescott on 15/01/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "Beacon+Additions.h"
#import "ContextManager.h"

@implementation Beacon (Additions)

+ (void)importBeacons:(NSArray *)beacons intoContext:(NSManagedObjectContext *)context error:(NSError **)error
{
    [Beacon sqk_insertOrUpdate:beacons
                uniqueModelKey:@"beaconID"
               uniqueRemoteKey:@"BeaconID"
           propertySetterBlock:^(NSDictionary *dictionary, Beacon *managedObject) {
               managedObject.beaconID = ![dictionary[@"BeaconID"] isEqual:[NSNull null]] ? dictionary[@"BeaconID"] : nil;
               managedObject.major = ![dictionary[@"Major"] isEqual:[NSNull null]] ? dictionary[@"Major"] : nil;
               managedObject.minor = ![dictionary[@"Minor"] isEqual:[NSNull null]] ? dictionary[@"Minor"] : nil;
               
               if(![dictionary[@"RoomID"] isEqual:[NSNull null]])
               {
                   managedObject.room = [Room sqk_insertOrFetchWithKey:@"roomID"
                                                                 value:dictionary[@"RoomID"]
                                                               context:context
                                                                 error:error];
               }
               
               managedObject.hasBeenUpdated = @YES;
           }
                privateContext:context
                         error:error];
}

+ (Beacon *)beaconWithMajor:(NSNumber *)major minor:(NSNumber *)minor inContext:(NSManagedObjectContext *)context
{
    if(major && minor)
    {
        NSError *error;
        
        NSFetchRequest *request = [Beacon sqk_fetchRequest];
        request.predicate = [NSPredicate predicateWithFormat:@"major == %@ AND minor == %@", major, minor];
        
        NSArray *beacons = [context executeFetchRequest:request error:&error];
        
        if(error)
        {
            NSLog(@"Error : %@", error.localizedDescription);
            return nil;
        }
        
        return [beacons firstObject];
    }
    
    return nil;
}

+ (void)deleteAllInvalidBeaconsInContext:(NSManagedObjectContext *)context
{
    NSError *error;
    [Beacon sqk_deleteAllObjectsInContext:context withPredicate:[NSPredicate predicateWithFormat:@"hasBeenUpdated == NO"] error:&error];
    
    if(error)
    {
        NSLog(@"Error : %@", error.localizedDescription);
    }
}

@end

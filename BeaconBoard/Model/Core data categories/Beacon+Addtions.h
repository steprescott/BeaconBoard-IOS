//
//  Beacon+Addtions.h
//  BeaconBoard
//
//  Created by Ste Prescott on 15/01/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "Beacon.h"

@interface Beacon (Addtions)

+ (void)importBeacons:(NSArray *)beacons intoContext:(NSManagedObjectContext *)context error:(NSError **)error;

@end

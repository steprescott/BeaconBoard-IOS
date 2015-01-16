//
//  Resource+Addtions.h
//  BeaconBoard
//
//  Created by Ste Prescott on 16/01/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "Resource.h"

@interface Resource (Addtions)

+ (void)importResources:(NSArray *)resources intoContext:(NSManagedObjectContext *)context error:(NSError **)error;

@end

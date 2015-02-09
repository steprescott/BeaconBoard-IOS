//
//  Module+Additions.h
//  BeaconBoard
//
//  Created by Ste Prescott on 08/02/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "Module.h"

@interface Module (Additions)

+ (void)importModules:(NSArray *)modules intoContext:(NSManagedObjectContext *)context error:(NSError **)error;
+ (void)deleteAllInvalidModulesInContext:(NSManagedObjectContext *)context;

@end

//
//  Course+Addtions.h
//  BeaconBoard
//
//  Created by Ste Prescott on 16/01/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "Course.h"

@interface Course (Addtions)

+ (void)importCources:(NSArray *)cources intoContext:(NSManagedObjectContext *)context error:(NSError **)error;

@end

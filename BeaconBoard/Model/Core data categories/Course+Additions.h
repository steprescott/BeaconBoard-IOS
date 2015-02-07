//
//  Course+Additions.h
//  BeaconBoard
//
//  Created by Ste Prescott on 16/01/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "Course.h"

@interface Course (Additions)

+ (void)importCources:(NSArray *)cources intoContext:(NSManagedObjectContext *)context error:(NSError **)error;
+ (void)deleteAllInvalidCoursesInContext:(NSManagedObjectContext *)context;

@end

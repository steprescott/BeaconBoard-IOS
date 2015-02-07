//
//  Lecturer+Additions.h
//  BeaconBoard
//
//  Created by Ste Prescott on 06/02/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "Lecturer.h"

@interface Lecturer (Additions)

+ (void)importLecturers:(NSArray *)lecturers intoContext:(NSManagedObjectContext *)context error:(NSError **)error;
+ (void)deleteAllInvalidLecturersInContext:(NSManagedObjectContext *)context;

@end

//
//  Student+Additions.h
//  BeaconBoard
//
//  Created by Ste Prescott on 03/02/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "Student.h"

@interface Student (Additions)

+ (void)importStudents:(NSArray *)students intoContext:(NSManagedObjectContext *)context withActiveUsername:(NSString *)username error:(NSError **)error;
+ (void)deleteAllInvalidStudentsInContext:(NSManagedObjectContext *)context;

@end

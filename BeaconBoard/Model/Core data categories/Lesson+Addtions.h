//
//  Lesson+Addtions.h
//  BeaconBoard
//
//  Created by Ste Prescott on 16/01/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "Lesson.h"

@interface Lesson (Addtions)

+ (void)importLessons:(NSArray *)lessons intoContext:(NSManagedObjectContext *)context error:(NSError **)error;

@end

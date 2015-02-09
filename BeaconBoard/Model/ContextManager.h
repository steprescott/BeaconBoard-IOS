//
//  ContextManager.h
//  BeaconBoard
//
//  Created by Ste Prescott on 15/01/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "SQKContextManager.h"
#import <SQKDataKit/SQKDataKit.h>

#import "Attendance+Additions.h"
#import "Beacon+Additions.h"
#import "Course+Additions.h"
#import "Lecturer+Additions.h"
#import "Lesson+Additions.h"
#import "Module+Additions.h"
#import "Resource+Additions.h"
#import "ResourceType+Additions.h"
#import "Room+Additions.h"
#import "Role+Additions.h"
#import "Session+Additions.h"
#import "Student+Additions.h"
#import "User+Additions.h"

@interface ContextManager : SQKContextManager

+ (NSManagedObjectContext *)mainContext;
+ (NSManagedObjectContext *)newPrivateContext;

@end

//
//  ContextManager.h
//  BeaconBoard
//
//  Created by Ste Prescott on 15/01/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "SQKContextManager.h"
#import <SQKDataKit/SQKDataKit.h>

#import "Beacon+Addtions.h"
#import "Course+Addtions.h"
#import "Lesson+Addtions.h"
#import "Resource+Addtions.h"
#import "ResourceType+Addtions.h"
#import "Room+Addtions.h"
#import "Session+Addtions.h"

@interface ContextManager : SQKContextManager

+ (NSManagedObjectContext *)mainContext;
+ (NSManagedObjectContext *)newPrivateContext;

@end

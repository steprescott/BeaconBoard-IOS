//
//  ContextManager.m
//  BeaconBoard
//
//  Created by Ste Prescott on 15/01/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "ContextManager.h"

@implementation ContextManager

static SQKContextManager *sharedManger;

+ (SQKContextManager *)sharedManger
{
    if (!sharedManger)
    {
        NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
        sharedManger = [[SQKContextManager alloc] initWithStoreType:NSSQLiteStoreType managedObjectModel:model orderedManagedObjectModelNames:nil storeURL:nil];
    }
    
    return sharedManger;
}

+ (NSManagedObjectContext *)mainContext
{
    return [[ContextManager sharedManger] mainContext];
}

+ (NSManagedObjectContext *)newPrivateContext
{
    return [[ContextManager sharedManger] newPrivateContext];
}

@end

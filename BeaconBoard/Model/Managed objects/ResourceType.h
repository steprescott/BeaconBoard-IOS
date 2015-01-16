//
//  ResourceType.h
//  BeaconBoard
//
//  Created by Ste Prescott on 16/01/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Resource;

@interface ResourceType : NSManagedObject

@property (nonatomic, retain) NSString * resourceTypeID;
@property (nonatomic, retain) NSString * resourceTypeDescription;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *resources;
@end

@interface ResourceType (CoreDataGeneratedAccessors)

- (void)addResourcesObject:(Resource *)value;
- (void)removeResourcesObject:(Resource *)value;
- (void)addResources:(NSSet *)values;
- (void)removeResources:(NSSet *)values;

@end

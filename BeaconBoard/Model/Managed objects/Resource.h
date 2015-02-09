//
//  Resource.h
//  BeaconBoard
//
//  Created by Ste Prescott on 08/02/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Lesson, ResourceType;

@interface Resource : NSManagedObject

@property (nonatomic, retain) NSNumber * hasBeenUpdated;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * resourceDescription;
@property (nonatomic, retain) NSString * resourceID;
@property (nonatomic, retain) NSString * urlString;
@property (nonatomic, retain) NSSet *lessons;
@property (nonatomic, retain) ResourceType *resourceType;
@end

@interface Resource (CoreDataGeneratedAccessors)

- (void)addLessonsObject:(Lesson *)value;
- (void)removeLessonsObject:(Lesson *)value;
- (void)addLessons:(NSSet *)values;
- (void)removeLessons:(NSSet *)values;

@end

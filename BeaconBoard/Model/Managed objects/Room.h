//
//  Room.h
//  BeaconBoard
//
//  Created by Ste Prescott on 08/02/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Beacon, Session;

@interface Room : NSManagedObject

@property (nonatomic, retain) NSNumber * hasBeenUpdated;
@property (nonatomic, retain) NSString * number;
@property (nonatomic, retain) NSString * roomID;
@property (nonatomic, retain) NSSet *beacons;
@property (nonatomic, retain) NSSet *sessions;
@end

@interface Room (CoreDataGeneratedAccessors)

- (void)addBeaconsObject:(Beacon *)value;
- (void)removeBeaconsObject:(Beacon *)value;
- (void)addBeacons:(NSSet *)values;
- (void)removeBeacons:(NSSet *)values;

- (void)addSessionsObject:(Session *)value;
- (void)removeSessionsObject:(Session *)value;
- (void)addSessions:(NSSet *)values;
- (void)removeSessions:(NSSet *)values;

@end

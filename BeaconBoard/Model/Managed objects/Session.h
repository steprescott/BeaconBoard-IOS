//
//  Session.h
//  BeaconBoard
//
//  Created by Ste Prescott on 16/01/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Lesson, Room;

@interface Session : NSManagedObject

@property (nonatomic, retain) NSString * sessionID;
@property (nonatomic, retain) NSDate * scheduledDate;
@property (nonatomic, retain) Room *room;
@property (nonatomic, retain) Lesson *lesson;

@end

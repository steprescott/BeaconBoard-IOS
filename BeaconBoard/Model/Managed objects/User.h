//
//  User.h
//  BeaconBoard
//
//  Created by Ste Prescott on 08/02/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Role;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * emailAddress;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSNumber * hasBeenUpdated;
@property (nonatomic, retain) NSNumber * isActiveUser;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * otherNames;
@property (nonatomic, retain) NSString * userID;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) Role *role;

@end

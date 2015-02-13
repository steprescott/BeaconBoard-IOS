//
//  BeaconHelper.h
//  BeaconBoard
//
//  Created by Ste Prescott on 09/02/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

@import Foundation;
@import UIKit;
@import CoreLocation;

static NSString *BeaconHelperErrorDomain = @"Beacon-Helper-Error-Domain";

typedef NS_ENUM(NSUInteger, BeaconHelperError) {
    BeaconHelperErrorAlwaysUsageDescriptionNotProvided = 800,
    BeaconHelperErrorRangingNotAvailable = 801,
    BeaconHelperErrorBluetoothIsOff = 802,
    BeaconHelperErrorNotAuthorised = 803
};

typedef NS_ENUM(NSInteger, NoBeaconInRange) {
    NoBeaconInRangeRSSI = -9999,
    NoBeaconInRangeProximity = -1,
    NoBeaconInRangeMajor = -1,
    NoBeaconInRangeMinor = -2,
    NoBeaconInRangeAccuracy = -1,
};

typedef void(^BeaconHelperFailureBlock)(NSError *error);
typedef void(^BeaconHelperDidRangeBeacons)(NSDictionary *beaconDictionary, NSDictionary *bestBeaconDictionary);

@interface BeaconHelper : NSObject

@property (nonatomic, copy) BeaconHelperFailureBlock failureBlock;
@property (nonatomic, copy) BeaconHelperDidRangeBeacons didRangeBeaconsBlock;

- (instancetype)initWithFailureBlock:(BeaconHelperFailureBlock)failureBlock;

+ (CLBeaconRegion *)regionFromUUIDString:(NSString *)regionUUIDString withIdentifier:(NSString *)identifier;
+ (NSString *)proximityStringForProximity:(CLProximity)proximity;

- (void)startRangingForRegion:(CLBeaconRegion *)region didRangeBeacons:(BeaconHelperDidRangeBeacons)didRangeBeaconsBlock;
- (void)stopRangingForRegion:(CLBeaconRegion *)region;

@end

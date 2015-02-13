//
//  BeaconHelper.m
//  BeaconBoard
//
//  Created by Ste Prescott on 09/02/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "BeaconHelper.h"

@interface BeaconHelper() <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation BeaconHelper

- (instancetype)initWithFailureBlock:(BeaconHelperFailureBlock)failureBlock
{
    self = [super init];
    
    if(self)
    {
        self.failureBlock = failureBlock;
        
        if(![NSBundle mainBundle].infoDictionary[@"NSLocationAlwaysUsageDescription"])
        {
            if(self.failureBlock)
            {
                self.failureBlock([NSError errorWithDomain:BeaconHelperErrorDomain
                                                      code:BeaconHelperErrorAlwaysUsageDescriptionNotProvided
                                                  userInfo:@{NSLocalizedDescriptionKey : @"Value for key NSLocationAlwaysUsageDescription is not defined in the App's info.plist this is needed for iOS8."}]);
            }
            return nil;
        }
        
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.activityType = CLActivityTypeOtherNavigation;
        [self.locationManager requestAlwaysAuthorization];
    }
    
    return self;
}

#pragma mark - Region creation

/**
 *  Creates and returns a CLBeaconRegion with a given UUID String and identifier.
 *
 *  @param regionUUIDString The UUID for the region.
 *  @param identifier   The identifier for the region.
 *
 *  @return A CLBeaconRegion with the given values set.
 */
+ (CLBeaconRegion *)regionFromUUIDString:(NSString *)regionUUIDString withIdentifier:(NSString *)identifier
{
    NSUUID *regionUUID = [[NSUUID alloc] initWithUUIDString:regionUUIDString];
    CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:regionUUID identifier:identifier];
    region.notifyEntryStateOnDisplay = YES;
    
    return region;
}

#pragma mark - Beacon helper methods

/**
 *  Returns a user friendly string for a given proximity
 *
 *  @param proximity The proximity that you wish to be shown as a string
 *
 *  @return A user friendly string to represent a proximity
 */
+ (NSString *)proximityStringForProximity:(CLProximity)proximity
{
    NSString *beaconProximityString = @"";
    
    switch (proximity)
    {
        case CLProximityImmediate:
        {
            beaconProximityString = @"Immediate";
            break;
        }
        case CLProximityNear:
        {
            beaconProximityString = @"Near";
            break;
        }
        case CLProximityFar:
        {
            beaconProximityString = @"Far";
            break;
        }
        case CLProximityUnknown:
        {
            beaconProximityString = @"Unknown";
            break;
        }
    }
    
    return beaconProximityString;
}

#pragma mark - Start Ranging methods

/**
 *  Tells the Location Manager to start ranging for a given region.
 *
 *  @param region               The region that you want to start ranging for.
 *  @param didRangeBeaconsBlock A block to be called when beacons are discovered.
 */
- (void)startRangingForRegion:(CLBeaconRegion *)region didRangeBeacons:(BeaconHelperDidRangeBeacons)didRangeBeaconsBlock
{
    self.didRangeBeaconsBlock = didRangeBeaconsBlock;
    
    [self.locationManager startRangingBeaconsInRegion:region];
}

#pragma mark - Stop Ranging methods

/**
 *  Stops ranging for a given region.
 *
 *  @param region The region you wish to stop ranging updates for.
 */
- (void)stopRangingForRegion:(CLBeaconRegion *)region
{
    [self.locationManager stopRangingBeaconsInRegion:region];
}

#pragma mark - CLLocationManager Delegates

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if(![CLLocationManager locationServicesEnabled])
    {
        if(self.failureBlock)
        {
            self.failureBlock([NSError errorWithDomain:BeaconHelperErrorDomain
                                                  code:BeaconHelperErrorNotAuthorised
                                              userInfo:@{NSLocalizedDescriptionKey : @"Couldn't turn on ranging. Location services are not enabled."}]);
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if(self.failureBlock)
    {
        self.failureBlock([NSError errorWithDomain:BeaconHelperErrorDomain
                                              code:BeaconHelperErrorBluetoothIsOff
                                          userInfo:@{NSLocalizedDescriptionKey : @"Please check bluetooth is on."}]);
    }
}

- (void)locationManager:(CLLocationManager *)manager rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error
{
    if(self.failureBlock)
    {
        self.failureBlock([NSError errorWithDomain:BeaconHelperErrorDomain
                                              code:BeaconHelperErrorBluetoothIsOff
                                          userInfo:@{NSLocalizedDescriptionKey : @"Please check bluetooth is on."}]);
    }
}

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    if(region.identifier)
    {
        if(beacons.count > 0)
        {
            NSMutableDictionary *beaconDictionary = [NSMutableDictionary dictionary];
            NSDictionary *bestBeaconDictionary;
            
            [beacons enumerateObjectsUsingBlock:^(CLBeacon *beacon, NSUInteger idx, BOOL *stop) {
                
                NSString *beaconID = [NSString stringWithFormat:@"%@.%@", beacon.major, beacon.minor];
                NSLog(@"Beacon ID %@", beaconID);
                
                beaconDictionary[beaconID] = @{@"identifier" : region.identifier ? region.identifier : @"",
                                               @"rssi" : beacon.rssi ? @(beacon.rssi) : @(NoBeaconInRangeRSSI),
                                               @"proximity" : beacon.proximity ? @(beacon.proximity) : @(NoBeaconInRangeProximity),
                                               @"major" : beacon.major ? beacon.major : @(NoBeaconInRangeMajor),
                                               @"minor" : beacon.minor ? beacon.minor : @(NoBeaconInRangeMinor),
                                               @"accuracy" : beacon.accuracy ? @(beacon.accuracy) : @(NoBeaconInRangeAccuracy)};
            }];
            
            NSArray *sortedBeaconIDs = [beaconDictionary keysSortedByValueUsingComparator:^NSComparisonResult(id beacon1, id becacon2) {
                return [beacon1[@"rssi"] compare:becacon2[@"rssi"]];
            }];
            
            if(sortedBeaconIDs.count > 1)
            {
                CGFloat beacon1RSSI = [beaconDictionary[sortedBeaconIDs[0]][@"rssi"] floatValue];
                CGFloat beacon2RSSI = [beaconDictionary[sortedBeaconIDs[1]][@"rssi"] floatValue];
                
                if((beacon1RSSI - beacon2RSSI) > 0.25)
                {
                    bestBeaconDictionary = beaconDictionary[sortedBeaconIDs[0]];
                }
            }
            else if(sortedBeaconIDs.count == 1)
            {
                bestBeaconDictionary = beaconDictionary[sortedBeaconIDs[0]];
            }
            
            if(self.didRangeBeaconsBlock)
            {
                self.didRangeBeaconsBlock(beaconDictionary, bestBeaconDictionary);
            }
        }
    }
}

@end

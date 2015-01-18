//
//  BeaconDiscoveryMasterTableViewController.m
//  BeaconBoard
//
//  Created by Ste Prescott on 18/01/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "BeaconDiscoveryMasterTableViewController.h"
#import <SQKBeaconHelper/SQKBeaconHelper.h>

NSString *const cellIdentifier = @"beaconCell";
CGFloat const RSSIDifferenceThreshold = -10;

typedef NS_ENUM(NSUInteger, TableViewSection) {
    TableViewSectionBeacons = 0,
    TableViewSectionTotal
};

@interface BeaconDiscoveryMasterTableViewController () <UISplitViewControllerDelegate>

@property (nonatomic, strong) SQKBeaconHelper *beaconHelper;
@property (nonatomic, strong) CLBeaconRegion *SHUCantorRegion;

@property (nonatomic, strong) NSArray *sortedDiscoveredBeaconKeys;
@property (nonatomic, strong) NSDictionary *discoveredBeacons;

@end

@implementation BeaconDiscoveryMasterTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.splitViewController.delegate = self;
    
    self.SHUCantorRegion = [SQKBeaconHelper regionFromUUIDString:@"112215A5-9A51-40D7-A5CA-F8CC8F8A89DE" withIdentifier:@"SHU_CANTOR"];
    
    [self scanForRoom];
}

- (void)scanForRoom
{
    [SQKBeaconHelper measuredPowerForBeaconWithRegion:self.SHUCantorRegion
                                          sampleCount:2
                                              success:^(CLBeaconRegion *region, NSDictionary *measuredPower) {
                                                  NSDictionary *beaconsForRegion = measuredPower[region.identifier];
                                                  self.discoveredBeacons = beaconsForRegion;
                                                  self.sortedDiscoveredBeaconKeys = [SQKBeaconHelper sortKeysByRssiWithBeaconDictionary:beaconsForRegion];
                                                  
                                                  if(beaconsForRegion.count == 0)
                                                  {
                                                      NSLog(@"No beacons found");
                                                  }
                                                  else if(beaconsForRegion.count == 1)
                                                  {
                                                      NSString *beaconKey = self.sortedDiscoveredBeaconKeys[0];
                                                      NSArray *beaconID = [beaconKey componentsSeparatedByString:@"."];
                                                      NSString *major = beaconID[0];
                                                      NSString *minor = beaconID[1];
                                                      CGFloat RSSI = [beaconsForRegion[beaconKey] floatValue];
                                                      
                                                      NSLog(@"Beacon %@.%@ with RSSI of %f", major, minor, RSSI);
                                                  }
                                                  else
                                                  {
                                                      NSString *beacon1Key = self.sortedDiscoveredBeaconKeys[0];
                                                      NSString *beacon2Key = self.sortedDiscoveredBeaconKeys[1];
                                                      
                                                      CGFloat beacon1RSSI = [beaconsForRegion[beacon1Key] floatValue];
                                                      CGFloat beacon2RSSI = [beaconsForRegion[beacon2Key] floatValue];
                                                      CGFloat RSSIDifferance = beacon1RSSI - beacon2RSSI;
                                                      
                                                      if(RSSIDifferance < RSSIDifferenceThreshold)
                                                      {
                                                          //We can guess they are nearest to beacon 1
                                                          NSArray *beaconID = [beacon1Key componentsSeparatedByString:@"."];
                                                          NSString *major = beaconID[0];
                                                          NSString *minor = beaconID[1];
                                                          CGFloat RSSI = [beaconsForRegion[beacon1Key] floatValue];
                                                          
                                                          NSLog(@"Beacon %@.%@ with RSSI of %f", major, minor, RSSI);
                                                      }
                                                      else
                                                      {
                                                          //The RSSI levels are too close to know what room
                                                          //Ask the user to select what of the two rooms are they in
                                                      }
                                                  }
                                                  
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      [self.tableView reloadData];
                                                  });
                                              }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger numberOfSections = TableViewSectionTotal;
    return numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = self.sortedDiscoveredBeaconKeys.count;
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSString *beaconKey = self.sortedDiscoveredBeaconKeys[indexPath.row];
    CGFloat beaconRSSI = [self.discoveredBeacons[beaconKey] floatValue];
    
    cell.textLabel.text = beaconKey;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%f", beaconRSSI];
    
    return cell;
}

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController
{
    return YES;
}

@end

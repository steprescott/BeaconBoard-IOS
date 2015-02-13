//
//  CurrentSessionTableViewController.m
//  BeaconBoard
//
//  Created by Ste Prescott on 09/02/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "SessionDetailTableViewController.h"
#import "BeaconHelper.h"
#import "ContextManager.h"
#import "WebClient.h"
#import "WebViewController.h"

typedef NS_ENUM(NSUInteger, TableViewSection) {
    TableViewSectionDetails = 0,
    TableViewSectionLecturers,
    TableViewSectionResources,
    TableViewSectionCount,
};

typedef NS_ENUM(NSUInteger, TableViewSectionDetailsRow) {
    TableViewSectionDetailsRowRoomNumber = 0,
    TableViewSectionDetailsRowModuleName,
    TableViewSectionDetailsRowLessonName,
    TableViewSectionDetailsRowStartDate,
    TableViewSectionDetailsRowEndDate,
    TableViewSectionDetailsRowCount
};

typedef NS_ENUM(NSUInteger, TableViewSectionLecturersRow) {
    TableViewSectionLecturersRowDetails = 0,
    TableViewSectionLecturersRowCount
};

typedef NS_ENUM(NSUInteger, TableViewSectionResourcesRow) {
    TableViewSectionResourcesRowResource = 0,
    TableViewSectionResourcesRowCount
};

@interface SessionDetailTableViewController ()

@property (nonatomic, strong) BeaconHelper *becaonHelper;
@property (nonatomic, strong) Beacon *discoveredBeacon;
@property (nonatomic, strong) CLBeaconRegion *shuRegion;

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation SessionDetailTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"dd/MM/YYYY hh:mm";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(!self.currentSession)
    {
        if(!self.becaonHelper)
        {
            self.becaonHelper = [[BeaconHelper alloc] initWithFailureBlock:^(NSError *error) {
                NSLog(@"Beacon helper error. %@", error.localizedDescription);
            }];
            
            self.shuRegion = [BeaconHelper regionFromUUIDString:@"112215A5-9A51-40D7-A5CA-F8CC8F8A89DE"
                                                 withIdentifier:@"SHU-Region"];
        }
        
        NSManagedObjectContext *mainContext = [ContextManager mainContext];
        
        [self.becaonHelper startRangingForRegion:self.shuRegion
                                 didRangeBeacons:^(NSDictionary *beaconDictionary, NSDictionary *bestBeaconDictionary) {
                                     [self.becaonHelper stopRangingForRegion:self.shuRegion];
                                     
                                     self.discoveredBeacon = [Beacon beaconWithMajor:bestBeaconDictionary[@"major"]
                                                                               minor:bestBeaconDictionary[@"minor"]
                                                                           inContext:mainContext];
                                     
                                     NSError *error;
                                     NSDictionary *sessionDictionary = [[WebClient sharedClient] GETCurrentSessionForRoomWithID:self.discoveredBeacon.room.roomID error:&error];
                                     
                                     if(error)
                                     {
                                         NSLog(@"Error : %@", error.localizedDescription);
                                     }
                                     else if(sessionDictionary)
                                     {
                                         self.currentSession = [Session sessionWithSessionID:sessionDictionary[@"SessionID"]
                                                                                   inContext:mainContext];
                                         [self.tableView reloadData];
                                     }
                                 }];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return TableViewSectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = 0;
    
    switch (section)
    {
        case TableViewSectionDetails:
        {
            numberOfRows = TableViewSectionDetailsRowCount;
            break;
        }
            
        case TableViewSectionLecturers:
        {
            numberOfRows = self.currentSession.lecturers.count;
            break;
        }
            
        case TableViewSectionResources:
        {
            numberOfRows = self.currentSession.lesson.reources.count;
            break;
        }
    }
    
    return numberOfRows;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle;
    
    switch (section)
    {
        case TableViewSectionDetails:
        {
            sectionTitle = @"Session details";
            break;
        }
            
        case TableViewSectionLecturers:
        {
            sectionTitle = @"Lecturers";
            break;
        }
            
        case TableViewSectionResources:
        {
            sectionTitle = @"Resources";
            break;
        }
    }
    
    return sectionTitle;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell" forIndexPath:indexPath];
    
    NSString *cellText;
    NSString *cellDetailText;
    
    switch (indexPath.section)
    {
        case TableViewSectionDetails:
        {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            switch (indexPath.row)
            {
                case TableViewSectionDetailsRowRoomNumber:
                {
                    cellText = @"Room number";
                    cellDetailText = self.currentSession.room.number;
                    break;
                }
                    
                case TableViewSectionDetailsRowModuleName:
                {
                    cellText = @"Module";
                    cellDetailText = self.currentSession.module.name;
                    break;
                }
                    
                case TableViewSectionDetailsRowLessonName:
                {
                    cellText = @"Lesson";
                    cellDetailText = self.currentSession.lesson.name;
                    break;
                }
                    
                case TableViewSectionDetailsRowStartDate:
                {
                    cellText = @"Start date";
                    cellDetailText = [self.dateFormatter stringFromDate:self.currentSession.scheduledStartDate];
                    break;
                }
                    
                case TableViewSectionDetailsRowEndDate:
                {
                    cellText = @"End date";
                    cellDetailText = [self.dateFormatter stringFromDate:self.currentSession.scheduledEndDate];
                    break;
                }
            }
            break;
        }
            
        case TableViewSectionLecturers:
        {
            Lecturer *lecturer = (Lecturer *)self.currentSession.lecturers.allObjects[indexPath.row];
            cellText = lecturer.fullName;
            cellDetailText = lecturer.emailAddress;
            break;
        }
            
        case TableViewSectionResources:
        {
            Resource *resource = (Resource *)self.currentSession.lesson.reources.allObjects[indexPath.row];
            cellText = [NSString stringWithFormat:@"%@ | %@", resource.name, resource.resourceType.name];
            cellDetailText = resource.resourceDescription;
        }
    }
    
    cell.textLabel.text = cellText;
    cell.detailTextLabel.text = cellDetailText;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case TableViewSectionDetails:
        {
            
            break;
        }
            
        case TableViewSectionLecturers:
        {
            
            break;
        }
            
        case TableViewSectionResources:
        {
            Resource *resource = (Resource *)self.currentSession.lesson.reources.allObjects[indexPath.row];
            
            UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"webViewController"];
            WebViewController *webViewController = (WebViewController *)[navigationController.viewControllers lastObject];
            
            webViewController.urlString = resource.urlString;
            webViewController.webViewTitle = resource.name;
            
            [self showViewController:webViewController sender:self];
            
            break;
        }
    }
}

@end

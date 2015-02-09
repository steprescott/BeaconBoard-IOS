//
//  SessionMasterTableViewController.h
//  BeaconBoard
//
//  Created by Ste Prescott on 08/02/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "SQKFetchedTableViewController.h"

@class Module;

@interface SessionMasterTableViewController : SQKFetchedTableViewController

@property (nonatomic, strong) Module *selectedModule;

@end

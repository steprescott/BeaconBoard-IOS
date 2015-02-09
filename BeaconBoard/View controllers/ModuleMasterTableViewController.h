//
//  ModuleMasterTableViewController.h
//  BeaconBoard
//
//  Created by Ste Prescott on 07/02/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "SQKFetchedTableViewController.h"

@class Course;

@interface ModuleMasterTableViewController : SQKFetchedTableViewController

@property (nonatomic, strong) Course *selectedCourse;

@end

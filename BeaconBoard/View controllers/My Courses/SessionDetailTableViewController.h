//
//  CurrentSessionTableViewController.h
//  BeaconBoard
//
//  Created by Ste Prescott on 09/02/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Session;

@interface SessionDetailTableViewController : UITableViewController

@property (nonatomic, strong) Session *currentSession;

@end

//
//  AppDelegate.m
//  BeaconBoard
//
//  Created by Ste Prescott on 15/01/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "AppDelegate.h"
#import "BeaconDiscoveryMasterTableViewController.h"
#import "DataSynchroniser.h"
#import "WebClient.h"
#import "ContextManager.h"

@interface AppDelegate () <UISplitViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
    navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem;
    
    NSString *username = @"student1";
    NSString *password = @"password";
    
    WebClient *webclient = [WebClient sharedClient];
    [webclient asyncLoginUsername:username
                         password:password
                          success:^(id responseObject) {
                              NSLog(@"Success");
                              [DataSynchroniser syncDataWithUsername:username];
                          } failure:^(NSError *error) {
                              NSLog(@"Error %@", error.localizedDescription);
                          }];
    
    return YES;
}

@end

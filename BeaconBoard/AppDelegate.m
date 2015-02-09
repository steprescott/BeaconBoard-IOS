//
//  AppDelegate.m
//  BeaconBoard
//
//  Created by Ste Prescott on 15/01/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "AppDelegate.h"
#import "WebClient.h"
#import "LoginTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if(![WebClient sharedClient].userToken)
    {
        LoginTableViewController *loginTableViewController = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"loginTableViewController"];
        
        dispatch_after(0, dispatch_get_main_queue(), ^{
        [self.window.rootViewController presentViewController:loginTableViewController
                                                     animated:NO
                                                   completion:nil];
        });
    }
    
    return YES;
}

@end

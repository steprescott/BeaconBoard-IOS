//
//  LoginTableViewController.m
//  BeaconBoard
//
//  Created by Ste Prescott on 07/02/2015.
//  Copyright (c) 2015 Ste Prescott. All rights reserved.
//

#import "LoginTableViewController.h"
#import "WebClient.h"
#import "DataSynchroniser.h"

@interface LoginTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)loginButtonWasTapped:(id)sender;

@end

@implementation LoginTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.usernameTextField.text = @"steprescott";
    self.passwordTextField.text = @"password";
}

- (IBAction)loginButtonWasTapped:(id)sender
{
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    if(username && ![username isEqualToString:@""])
    {
        if(password && ![password isEqualToString:@""])
        {
            [[WebClient sharedClient] asyncLoginUsername:username
                                                password:password
                                                 success:^(id responseObject) {
                                                     [DataSynchroniser syncData];
                                                     [self dismissViewControllerAnimated:YES
                                                                              completion:nil];
                                                 }
                                                 failure:^(NSError *error) {
                                                     NSLog(@"Error when loggin in. %@", error.userInfo[WebClientErrorMessage]);
                                                 }];
        }
        else
        {
            NSLog(@"No password");
        }
    }
    else
    {
        NSLog(@"No username");
    }
}

@end

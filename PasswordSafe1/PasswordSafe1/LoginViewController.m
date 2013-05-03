//
//  LoginViewController.m
//  PasswordSafe1
//
//  Created by CSSE Department on 3/28/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize usernameField = __usernameField;
@synthesize passwordField = __passwordField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)theCreateButtonOnTheAddLoginViewControllerWasTapped:(AddLoginViewController *)controller{
    [controller.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)login:(id)sender
{
    BOOL foundUser = FALSE;
    
    NSFetchRequest *fetchUsers = [[NSFetchRequest alloc] init];
    [fetchUsers setEntity:[NSEntityDescription entityForName:@"User" inManagedObjectContext:[[AppDelegate sharedAppDelegate] managedObjectContext]]];
    NSArray *users = [[[AppDelegate sharedAppDelegate] managedObjectContext] executeFetchRequest:fetchUsers error:nil];
    
    for(User *user in users){
        if([[user masterUsername] isEqualToString:__usernameField.text]){
            foundUser = TRUE;
            if([[user masterPassword] isEqualToString:__passwordField.text]){
                [[AppDelegate sharedAppDelegate] loggedIn];
                [[AppDelegate sharedAppDelegate] setUser:user];
                [[AppDelegate sharedAppDelegate] sync];
                [self dismissViewControllerAnimated:YES completion:^(void){
                    [[AppDelegate sharedAppDelegate] setServerURL:[user serverURL]];
                    [[AppDelegate sharedAppDelegate] setUsername:[user serverUsername]];
                    [[AppDelegate sharedAppDelegate] setPassword:[user serverPassword]];
                }];
                
            } else {
                [self PasswordIsInvalidPopup];
            }
        }
    }
    
    if(!foundUser){
        [self UsernameIsInvalidPopup];
    }
}

- (void)UsernameIsInvalidPopup{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failed "
                                                    message:@"Username not found"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)PasswordIsInvalidPopup{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failed"
                                                    message:@"Password Incorrect"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}



@end

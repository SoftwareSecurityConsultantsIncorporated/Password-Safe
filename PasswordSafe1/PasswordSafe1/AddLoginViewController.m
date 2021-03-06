//
//  AddLoginViewController.m
//  PasswordSafe1
//
//  Created by CSSE Department on 5/1/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import "AddLoginViewController.h"

@interface AddLoginViewController ()

@end

@implementation AddLoginViewController

@synthesize usernameTextField = __usernameTextField;
@synthesize passwordTextField = __passwordTextField;
@synthesize passwordCheckTextField = __passwordCheckTextField;

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

- (IBAction)save:(id)sender
{
    if([__passwordTextField.text isEqualToString:__passwordCheckTextField.text]){
        BOOL foundUser = FALSE;
        
        NSFetchRequest *fetchUsers = [[NSFetchRequest alloc] init];
        [fetchUsers setEntity:[NSEntityDescription entityForName:@"User" inManagedObjectContext:[[AppDelegate sharedAppDelegate] managedObjectContext]]];
        NSArray *users = [[[AppDelegate sharedAppDelegate] managedObjectContext] executeFetchRequest:fetchUsers error:nil];
        
        for(User *user in users){
            if([[user masterUsername] isEqualToString:__usernameTextField.text]){
                foundUser = TRUE;
            }
        }

        if(!foundUser){
            User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User"
                                                       inManagedObjectContext:[[AppDelegate sharedAppDelegate] managedObjectContext]];
    
            user.masterUsername = __usernameTextField.text;
            user.masterPassword = __passwordTextField.text;
            
            [self SaveIsValidPopup];
            
            [[[AppDelegate sharedAppDelegate] managedObjectContext] save:nil];  // write to database
        } else {
            [self UsernameIsInvalidPopup];
        }
    
        [self.delegate theCreateButtonOnTheAddLoginViewControllerWasTapped:self];
    } else {
        [self SaveIsInvalidPopup];
    }
}

- (void)SaveIsInvalidPopup{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Creation was Unsuccessful"
                                                    message:@"Passwords are not the same"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)SaveIsValidPopup{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Creation was Successful"
                                                    message:@"User account created"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)UsernameIsInvalidPopup{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Creation was Unsuccessful"
                                                    message:@"Username already exists"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end

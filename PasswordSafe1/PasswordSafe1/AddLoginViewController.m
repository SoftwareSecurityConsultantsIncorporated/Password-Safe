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
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender
{
    if([__passwordTextField.text isEqualToString:__passwordCheckTextField.text]){
        User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User"
                                                       inManagedObjectContext:self.managedObjectContext];
    
        user.masterUsername = __usernameTextField.text;
        user.masterPassword = __passwordTextField.text;
        [self.managedObjectContext save:nil];  // write to database
    
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

@end

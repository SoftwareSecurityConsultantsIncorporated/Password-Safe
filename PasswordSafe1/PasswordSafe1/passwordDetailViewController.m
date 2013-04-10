//
//  passwordDetailViewController.m
//  PasswordSafe1
//
//  Created by CSSE Department on 2/13/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import "passwordDetailViewController.h"
#import "passwordViewController.h"
#import "AddPasswordViewController.h"
@interface AddpasswordViewController ()

@end

@implementation passwordDetailViewController

@synthesize managedObjectContext = __managedObjectContext;
@synthesize accountTitleTextField = __accountTitleTextField;
@synthesize userNameTextField = __userNameTextField;
@synthesize passwordTextField = __passwordTextField;
@synthesize websiteTextField = __websiteTextField;
@synthesize accountDescriptionTextField = __accountDescriptionTextField;
@synthesize password = __password;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"Setting the value of fields in this static table to that of the passed password");
    self.accountTitleTextField.text = self.password.title;
    self.passwordTextField.text = self.password.password;
    self.userNameTextField.text = self.password.username;
    self.websiteTextField.text = self.password.site;
    self.accountDescriptionTextField.text = self.password.pwDescription;
    [super viewDidLoad];
    
}

- (IBAction)save:(id)sender
{
    NSLog(@"Telling the AddPassword Delegate that Save was tapped on the EditpasswordController");
    [self.password setTitle:__accountTitleTextField.text];
    [self.password setPassword:__passwordTextField.text];
    [self.password setUsername:__userNameTextField.text];
    [self.password setSite:__websiteTextField.text];
    [self.password setPwDescription:__accountDescriptionTextField.text];
    [self.managedObjectContext save:nil];  // write to database
    
    [self.delegate theSaveButtonOnTheEditpasswordViewControllerWasTapped:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end

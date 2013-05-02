//
//  AddpasswordViewController.m
//  passwordSafe1
//
//  Created by CSSE Department on 2/12/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import "AddpasswordViewController.h"
#import "passwordViewController.h"
@interface AddpasswordViewController ()

@end

@implementation AddpasswordViewController

@synthesize managedObjectContext = __managedObjectContext;
@synthesize accountTitleTextField = __accountTitleTextField;
@synthesize userNameTextField = __userNameTextField;
@synthesize passwordTextField = __passwordTextField;
@synthesize websiteTextField = __websiteTextField;
@synthesize accountDescriptionTextField = __accountDescriptionTextField;

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
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (IBAction)save:(id)sender
{
    NSLog(@"Telling the AddPassword Delegate that Save was tapped on the AddPassword");
    
    Password *password = [NSEntityDescription insertNewObjectForEntityForName:@"Password"
                                               inManagedObjectContext:self.managedObjectContext];
    
    password.title = __accountTitleTextField.text;
    password.username = __userNameTextField.text;
    password.password = __passwordTextField.text;
    password.site = __websiteTextField.text;
    password.pwDecscription = __accountDescriptionTextField.text;
    [self.managedObjectContext save:nil];  // write to database
    
    [self.delegate theSaveButtonOnTheAddpasswordViewControllerWasTapped:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

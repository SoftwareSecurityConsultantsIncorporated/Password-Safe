//
//  passwordDetailViewController.h
//  passwordSafe1
//
//  Created by CSSE Department on 2/13/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>
#import "password.h"
@class passwordDetailViewController;

@protocol passwordDetailViewControllerDelegate

- (void)theSaveButtonOnTheEditpasswordViewControllerWasTapped:(passwordDetailViewController *)controller;

@end

@interface passwordDetailViewController : UITableViewController
@property (nonatomic, weak) id <passwordDetailViewControllerDelegate> delegate;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Password *password;
@property (strong, nonatomic) IBOutlet UITextField *accountTitleTextField;
@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *websiteTextField;
@property (strong, nonatomic) IBOutlet UITextField *accountDescriptionTextField;
- (IBAction)save:(id)sender;

@end
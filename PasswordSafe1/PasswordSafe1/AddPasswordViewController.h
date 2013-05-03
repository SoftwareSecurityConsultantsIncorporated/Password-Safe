//
//  AddpasswordViewController.h
//  passwordSafe1
//
//  Created by CSSE Department on 2/12/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "password.h"
@class AddpasswordViewController;

@protocol AddpasswordControllerDelegate

- (void)theSaveButtonOnTheAddpasswordViewControllerWasTapped:(AddpasswordViewController *)controller;

@end

@interface AddpasswordViewController : UITableViewController {
    NSString *passedPassword;
}

@property (nonatomic, weak) id <AddpasswordControllerDelegate> delegate;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) IBOutlet UITextField *accountTitleTextField;
@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *websiteTextField;
@property (strong, nonatomic) IBOutlet UITextField *accountDescriptionTextField;

- (IBAction)save:(id)sender;
- (void)setPassword:(NSString *)password;

@end
